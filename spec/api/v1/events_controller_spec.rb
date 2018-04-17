describe 'Events API' do
  describe 'GET #index' do
    let!(:events) { create_list(:event, 2) }
    before { get '/api/v1/events', params: { format: :json } }

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'and contains list of events' do
      expect(JSON.parse(response.body)['events'].size).to eq 2
    end

    it 'and contains serialized events objects' do
      expect(response.body).to be_json_eql(EventSerializer.new(events.first).serializable_hash.to_json).at_path('events/0')
      expect(response.body).to be_json_eql(EventSerializer.new(events.last).serializable_hash.to_json).at_path('events/1')
    end
  end
end
