RSpec.describe Member, type: :model do
  it { should belong_to :user }
  it { should have_one(:basket).dependent(:destroy) }
  it { should have_many(:photos).dependent(:destroy) }
  it { should validate_presence_of :user }
  it { should validate_presence_of :name }
  it { should validate_presence_of :title }

  it 'should be valid' do
    member = create :member

    expect(member).to be_valid
  end

  describe '.credit' do
    let!(:member) { create :member }

    it 'returns amount in basket' do
      expect(member.credit).to eq member.basket.amount
    end
  end

  describe '.create_basket' do
    it 'creates basket for new member' do
      expect { create :member }.to change { Basket.count }.by(1)
    end
  end
end
