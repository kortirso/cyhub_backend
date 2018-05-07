RSpec.describe Event, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :link }
  it { should validate_presence_of :description }

  it 'should be valid' do
    event = create :event

    expect(event).to be_valid
  end

  describe '.image_link' do
    let!(:event) { create :event }

    it 'returns nil if there is no image' do
      expect(event.image_link).to eq nil
    end

    it 'does not return nil if there is image' do
      event.image.attach(Rack::Test::UploadedFile.new("#{Rails.root}/spec/test_files/test.jpg"))

      expect(event.image_link).to_not eq nil
    end
  end
end
