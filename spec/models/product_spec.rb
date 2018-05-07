RSpec.describe Product, type: :model do
  it { should have_many(:positions).dependent(:destroy) }
  it { should have_many(:baskets).through(:positions) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

  it 'should be valid' do
    product = create :product

    expect(product).to be_valid
  end

  describe '.image_link' do
    let!(:product) { create :product }

    it 'returns nil if there is no image' do
      expect(product.image_link).to eq nil
    end

    it 'does not return nil if there is image' do
      product.image.attach(Rack::Test::UploadedFile.new("#{Rails.root}/spec/test_files/test.jpg"))

      expect(product.image_link).to_not eq nil
    end
  end
end
