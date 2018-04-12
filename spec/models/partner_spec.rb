RSpec.describe Partner, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :label }
  it { should validate_presence_of :description }
  it { should validate_presence_of :link }

  it 'should be valid' do
    partner = create :partner

    expect(partner).to be_valid
  end
end
