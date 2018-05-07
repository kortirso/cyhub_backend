RSpec.describe Partner, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :label }
  it { should validate_presence_of :description }
  it { should validate_presence_of :link }

  it 'should be valid' do
    partner = create :partner

    expect(partner).to be_valid
  end

  describe '.logo_link' do
    let!(:partner) { create :partner }

    it 'returns nil if there is no image' do
      expect(partner.logo_link).to eq nil
    end

    it 'does not return nil if there is image' do
      partner.logo.attach(Rack::Test::UploadedFile.new("#{Rails.root}/spec/test_files/test.jpg"))

      expect(partner.logo_link).to_not eq nil
    end
  end
end
