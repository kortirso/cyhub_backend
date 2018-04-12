describe 'Partners API' do
  describe 'GET #index' do
    let!(:partners) { create_list(:partner, 2) }
    before { get '/api/v1/partners', params: { format: :json } }

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'and contains list of partners' do
      expect(JSON.parse(response.body)['partners'].size).to eq 2
    end

    it 'and contains serialized partners objects' do
      expect(response.body).to be_json_eql(PartnerSerializer.new(partners.first).serializable_hash.to_json).at_path('partners/0')
      expect(response.body).to be_json_eql(PartnerSerializer.new(partners.last).serializable_hash.to_json).at_path('partners/1')
    end
  end
end
