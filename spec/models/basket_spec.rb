RSpec.describe Basket, type: :model do
  it { should belong_to :member }
  it { should validate_presence_of :member }
  it { should validate_presence_of :amount }
  it { should validate_numericality_of(:amount).only_integer.is_greater_than_or_equal_to(0) }

  it 'should be valid' do
    basket = create :basket

    expect(basket).to be_valid
  end
end
