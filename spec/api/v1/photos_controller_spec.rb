describe 'Photos API' do
  describe 'GET #index' do
    let!(:photos) { create_list(:photo, 2) }
    before { get '/api/v1/photos', params: { format: :json } }

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'and contains list of photos' do
      expect(JSON.parse(response.body)['photos'].size).to eq 2
    end

    it 'and contains serialized photos objects' do
      expect(response.body).to be_json_eql(PhotoSerializer.new(photos.first).serializable_hash.to_json).at_path('photos/0')
      expect(response.body).to be_json_eql(PhotoSerializer.new(photos.last).serializable_hash.to_json).at_path('photos/1')
    end
  end
end
