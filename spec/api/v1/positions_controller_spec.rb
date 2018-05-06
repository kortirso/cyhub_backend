describe 'Positions API' do
  describe 'POST #create' do
    let!(:user) { create :user, email: 'simple@email.com', password: '12345678' }

    context 'if member does not exist' do
      let(:request) { post '/api/v1/positions', params: { email: user.email, password: user.password, product_id: 111, format: :json } }

      it 'does not create new position' do
        expect { request }.to_not change(Position, :count)
      end

      context 'in answer' do
        before { request }

        it 'returns status 404' do
          expect(response.status).to eq 404
        end

        it 'and returns error message' do
          expect(JSON.parse(response.body)).to eq('error' => 'User does not have membership')
        end
      end
    end

    context 'if product does not exist' do
      let!(:member) { create :member, user: user }
      let(:request) { post '/api/v1/positions', params: { email: user.email, password: user.password, product_id: 111, format: :json } }

      it 'does not create new position' do
        expect { request }.to_not change(Position, :count)
      end

      context 'in answer' do
        before { request }

        it 'returns status 404' do
          expect(response.status).to eq 404
        end

        it 'and returns error message' do
          expect(JSON.parse(response.body)).to eq('error' => 'Product does not exist')
        end
      end
    end

    context 'for valid data' do
      let!(:member) { create :member, user: user }
      let!(:product) { create :product }
      let(:request) { post '/api/v1/positions', params: { email: user.email, password: user.password, product_id: product.id, format: :json } }

      it 'creates new position' do
        expect { request }.to_not change(Position, :count)
      end

      context 'in answer' do
        before { request }

        it 'returns status 200' do
          expect(response.status).to eq 200
        end

        %w[id amount].each do |attr|
          it "and contains basket #{attr}" do
            expect(response.body).to be_json_eql(Basket.last.send(attr.to_sym).to_json).at_path("basket/#{attr}")
          end
        end
      end
    end
  end
end
