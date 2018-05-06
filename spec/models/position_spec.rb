RSpec.describe Position, type: :model do
  it { should belong_to :basket }
  it { should belong_to :product }
  it { should validate_presence_of :basket }
  it { should validate_presence_of :product }
  it { should validate_presence_of :amount }
  it { should validate_numericality_of(:amount).only_integer.is_greater_than_or_equal_to(1) }

  it 'should be valid' do
    position = create :position

    expect(position).to be_valid
  end
end
