describe 'Users API' do
  describe 'GET #me' do
    let(:request) { get '/api/v1/users/me', params: { email: 'simple@email.com', password: '12345678', format: :json } }

    context 'if user does not exist' do
      it 'creates new user' do
        expect { request }.to change { User.count }.by(1)
      end

      context 'in answer' do
        before { request }

        it 'returns status 200' do
          expect(response.status).to eq 200
        end

        %w[id email username].each do |attr|
          it "and contains #{attr}" do
            expect(response.body).to be_json_eql(User.last.send(attr.to_sym).to_json).at_path("user/#{attr}")
          end
        end

        %w[password encrypted_password].each do |attr|
          it "and does not contains #{attr}" do
            expect(response.body).to_not have_json_path("user/#{attr}")
          end
        end
      end
    end

    context 'if user exists' do
      let!(:user) { create :user, email: 'simple@email.com', password: '12345678' }

      context 'for valid data' do
        it 'does not create new user' do
          expect { request }.to_not change(User, :count)
        end

        context 'in answer' do
          before { request }

          it 'returns status 200' do
            expect(response.status).to eq 200
          end

          %w[id email username].each do |attr|
            it "and contains #{attr}" do
              expect(response.body).to be_json_eql(User.last.send(attr.to_sym).to_json).at_path("user/#{attr}")
            end
          end

          %w[password encrypted_password].each do |attr|
            it "and does not contains #{attr}" do
              expect(response.body).to_not have_json_path("user/#{attr}")
            end
          end
        end
      end

      context 'for invalid data' do
        let(:invalid_request) { get '/api/v1/users/me', params: { email: 'simple@email.com', password: '1234', format: :json } }

        it 'does not create new user' do
          expect { invalid_request }.to_not change(User, :count)
        end

        context 'in answer' do
          before { invalid_request }

          it 'returns status 401' do
            expect(response.status).to eq 401
          end

          it 'and returns error message' do
            expect(JSON.parse(response.body)).to eq('error' => 'Unauthorized')
          end
        end
      end
    end
  end
end
