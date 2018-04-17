RSpec.describe Photo, type: :model do
  it { should belong_to :member }
  it { should validate_presence_of :member }

  it 'should be valid' do
    photo = create :photo

    expect(photo).to be_valid
  end
end
