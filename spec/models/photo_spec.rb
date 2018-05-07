RSpec.describe Photo, type: :model do
  it { should belong_to :member }
  it { should validate_presence_of :member }

  it 'should be valid' do
    photo = create :photo

    expect(photo).to be_valid
  end

  describe 'class methods' do
    context '.with_real_attachments' do
      let!(:photo1) { create :photo }
      let!(:photo2) { create :photo }
      before { photo2.image.attach(Rack::Test::UploadedFile.new("#{Rails.root}/frontend/images/link-facebook.jpg")) }

      it 'returns photos with attachments' do
        result = Photo.with_real_attachments

        expect(result.size).to eq 1
        expect(result[0]).to eq photo2
      end
    end
  end

  describe '.image_link' do
    let!(:photo) { create :photo }

    it 'returns nil if there is no image' do
      expect(photo.image_link).to eq nil
    end

    it 'does not return nil if there is image' do
      photo.image.attach(Rack::Test::UploadedFile.new("#{Rails.root}/spec/test_files/test.jpg"))

      expect(photo.image_link).to_not eq nil
    end
  end
end
