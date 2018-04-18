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

  describe 'POST #create' do
    let!(:user) { create :user }

    context 'for unlogged user' do
      let(:request) { post '/api/v1/photos', params: { email: user.email, password: '', photo: {}, format: :json } }

      it 'returns 401 status' do
        request

        expect(response.status).to eq 401
      end

      it 'and returns error message' do
        request

        expect(JSON.parse(response.body)).to eq('error' => 'Unauthorized')
      end

      it 'and does not create new Photo' do
        expect { request }.to_not change(Photo, :count)
      end
    end

    context 'for user without membership' do
      let(:request) { post '/api/v1/photos', params: { email: user.email, password: user.password, photo: {}, format: :json } }

      it 'returns 404 status' do
        request

        expect(response.status).to eq 404
      end

      it 'and returns error message' do
        request

        expect(JSON.parse(response.body)).to eq('error' => 'User does not have membership')
      end

      it 'and does not create new Photo' do
        expect { request }.to_not change(Photo, :count)
      end
    end

    context 'for user with membership' do
      let!(:member) { create :member, user: user }

      context 'without photo' do
        let(:request) { post '/api/v1/photos', params: { email: user.email, password: user.password, photo: { image: nil }, format: :json } }

        it 'returns 404 status' do
          request

          expect(response.status).to eq 404
        end

        it 'and returns error message' do
          request

          expect(JSON.parse(response.body)).to eq('error' => 'There is no photo')
        end

        it 'and does not create new Photo' do
          expect { request }.to_not change(Photo, :count)
        end
      end

      context 'with photo' do
        let(:request) { post '/api/v1/photos', params: { email: user.email, password: user.password, photo: { image: Rack::Test::UploadedFile.new("#{Rails.root}/frontend/images/link-facebook.jpg") }, format: :json } }

        it 'returns 200 status' do
          request

          expect(response.status).to eq 200
        end

        it 'and returns array of photos' do
          request

          expect(JSON.parse(response.body)['photos'].is_a?(Array)).to eq true
        end

        it 'and creates new Photo' do
          expect { request }.to change(Photo, :count).by(1)
        end
      end
    end
  end
end
