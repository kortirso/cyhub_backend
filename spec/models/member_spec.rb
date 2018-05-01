RSpec.describe Member, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should validate_presence_of :name }
  it { should validate_presence_of :title }

  it 'should be valid' do
    member = create :member

    expect(member).to be_valid
  end
end
