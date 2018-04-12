RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      it 'renders users#index' do
        get :index, params: { locale: 'en' }

        expect(response).to render_template :index
      end
    end

    def do_request
      get :index, params: { locale: 'en' }
    end
  end

  describe 'GET #edit' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for unexisted user' do
        it 'renders error page' do
          get :edit, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed user' do
        let!(:user) { create :user }

        it 'renders users#edit' do
          get :edit, params: { id: user.id, locale: 'en' }

          expect(response).to render_template :edit
        end
      end
    end

    def do_request
      get :index, params: { id: 1, locale: 'en' }
    end
  end

  describe 'PATCH #update' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for unexisted user' do
        it 'renders error page' do
          patch :update, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed user' do
        let!(:user) { create :user }
        let(:request) { patch :update, params: { username: 'admin', id: user.id, locale: 'en' } }

        it 'changes user object' do
          request
          user.reload

          expect(user.username).to eq 'admin'
        end

        it 'and redirects to users path' do
          request

          expect(response).to redirect_to users_en_path
        end
      end
    end

    def do_request
      patch :update, params: { id: 111, locale: 'en' }
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for unexisted user' do
        it 'renders error page' do
          delete :destroy, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed user' do
        let!(:user) { create :user }
        let(:request) { delete :destroy, params: { id: user.id, locale: 'en' } }

        it 'destroys user object' do
          expect { request }.to change { User.count }.by(-1)
        end

        it 'and redirects to users path' do
          request

          expect(response).to redirect_to users_en_path
        end
      end
    end

    def do_request
      delete :destroy, params: { id: 111, locale: 'en' }
    end
  end
end
