describe 'Welcome API' do
  describe 'GET #index' do
    let!(:partners) { create_list(:partner, 2) }
    let!(:members) { create_list(:member, 2, :active) }
    let!(:events) { create_list(:event, 2) }
    before { get '/api/v1/welcome', params: { format: :json } }

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'and contains list of partners' do
      expect(JSON.parse(response.body)['partners'].size).to eq 2
    end

    it 'and contains list of members' do
      expect(JSON.parse(response.body)['members'].size).to eq 2
    end

    it 'and contains list of events' do
      expect(JSON.parse(response.body)['events'].size).to eq 2
    end

    it 'and contains list of photos' do
      expect(JSON.parse(response.body)['photos'].size).to eq 0
    end
  end
end
