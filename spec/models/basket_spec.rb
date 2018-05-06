RSpec.describe Basket, type: :model do
  it { should belong_to :member }
  it { should have_many(:positions).dependent(:destroy) }
  it { should have_many(:products).through(:positions) }
  it { should validate_presence_of :member }
  it { should validate_presence_of :amount }
  it { should validate_numericality_of(:amount).only_integer.is_greater_than_or_equal_to(0) }

  it 'should be valid' do
    basket = create :basket

    expect(basket).to be_valid
  end

  describe '.recalc' do
    let!(:basket) { create :basket }

    it 'updates baskets amount' do
      expect { create :position, basket: basket }.to change(basket, :amount)
    end
  end

  describe '.clear' do
    let!(:basket) { create :basket }
    let!(:positions) { create_list(:position, 2, basket: basket) }

    it 'destroys all positions' do
      expect { basket.clear }.to change { Position.count }.by(-2)
    end

    it 'and resets basket amount' do
      expect { basket.clear }.to change { basket.amount }.to(0)
    end
  end
end
