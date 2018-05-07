RSpec.describe Basket, type: :model do
  it { should belong_to :member }
  it { should have_many(:positions).dependent(:destroy) }
  it { should have_many(:products).through(:positions) }
  it { should validate_presence_of :member }
  it { should validate_presence_of :amount }
  it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }

  it 'should be valid' do
    basket = create :basket

    expect(basket).to be_valid
  end

  describe '.add_product' do
    let!(:basket) { create :basket }
    let!(:product) { create :product }
    let(:request) { basket.add_product(product) }

    context 'if position does not exist' do
      it 'creates new position' do
        expect { request }.to change { Position.count }.by(1)
      end

      it 'and basket recals' do
        expect { request }.to change(basket, :amount)
      end
    end

    context 'if position exists' do
      let!(:position) { create :position, basket: basket, product: product }

      it 'does not create new position' do
        expect { request }.to_not change(Position, :count)
      end

      it 'updates existed position by 1' do
        old_amount = position.amount
        request
        position.reload

        expect(position.amount - 1 == old_amount).to eq true
      end

      it 'and basket recals' do
        expect { request }.to change(basket, :amount)
      end
    end
  end

  describe '.recalc' do
    let!(:basket) { create :basket }
    let!(:position) { create :position, basket: basket }

    it 'updates baskets amount' do
      expect { basket.recalc }.to change(basket, :amount)
    end
  end

  describe '.clear' do
    let!(:basket) { create :basket }
    let!(:positions) { create_list(:position, 2, basket: basket) }
    before { basket.recalc }

    it 'destroys all positions' do
      expect { basket.clear }.to change { Position.count }.by(-2)
    end

    it 'and resets basket amount' do
      expect { basket.clear }.to change { basket.amount }.to(0)
    end
  end
end
