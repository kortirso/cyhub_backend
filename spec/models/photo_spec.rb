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
end
