describe 'Members API' do
  describe 'GET #index' do
    let!(:members) { create_list(:member, 2, :active) }
    before { get '/api/v1/members', params: { format: :json } }

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'and contains list of members' do
      expect(JSON.parse(response.body)['members'].size).to eq 2
    end

    it 'and contains serialized members objects' do
      expect(response.body).to be_json_eql(MemberSerializer.new(members.first).serializable_hash.to_json).at_path('members/0')
      expect(response.body).to be_json_eql(MemberSerializer.new(members.last).serializable_hash.to_json).at_path('members/1')
    end
  end
end
