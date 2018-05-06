describe 'Products API' do
  describe 'GET #index' do
    let!(:products) { create_list(:product, 2) }
    before { get '/api/v1/products', params: { format: :json } }

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'and contains list of products' do
      expect(JSON.parse(response.body)['products'].size).to eq 2
    end

    it 'and contains serialized products objects' do
      expect(response.body).to be_json_eql(ProductSerializer.new(products.first).serializable_hash.to_json).at_path('products/0')
      expect(response.body).to be_json_eql(ProductSerializer.new(products.last).serializable_hash.to_json).at_path('products/1')
    end
  end
end
