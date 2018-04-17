RSpec.describe Event, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :link }
  it { should validate_presence_of :description }

  it 'should be valid' do
    event = create :event

    expect(event).to be_valid
  end
end
