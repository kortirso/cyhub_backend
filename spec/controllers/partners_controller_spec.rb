RSpec.describe PartnersController, type: :controller do
  describe 'GET #index' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      it 'renders partners#index' do
        get :index, params: { locale: 'en' }

        expect(response).to render_template :index
      end
    end

    def do_request
      get :index, params: { locale: 'en' }
    end
  end

  describe 'POST #create' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for invalid data partner' do
        it 'renders new page' do
          post :create, params: { partner: { name: 'admin' }, locale: 'en' }

          expect(response).to render_template :new
        end
      end

      context 'for valid partner' do
        let(:request) { post :create, params: { partner: { name: 'admin', label: '1', description: '2', link: '3' }, locale: 'en' } }

        it 'creates new partner' do
          expect { request }.to change { Partner.count }.by(1)
        end

        it 'and redirects to partners path' do
          request

          expect(response).to redirect_to partners_en_path
        end
      end
    end

    def do_request
      post :create, params: { partner: {}, locale: 'en' }
    end
  end

  describe 'GET #edit' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for unexisted partner' do
        it 'renders error page' do
          get :edit, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed partner' do
        let!(:partner) { create :partner }

        it 'renders partners#edit' do
          get :edit, params: { id: partner.id, locale: 'en' }

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

      context 'for unexisted partner' do
        it 'renders error page' do
          patch :update, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed partner' do
        let!(:partner) { create :partner }
        let(:request) { patch :update, params: { partner: { name: 'admin' }, id: partner.id, locale: 'en' } }

        it 'changes partner object' do
          request
          partner.reload

          expect(partner.name).to eq 'admin'
        end

        it 'and redirects to partners path' do
          request

          expect(response).to redirect_to partners_en_path
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

      context 'for unexisted partner' do
        it 'renders error page' do
          delete :destroy, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed partner' do
        let!(:partner) { create :partner }
        let(:request) { delete :destroy, params: { id: partner.id, locale: 'en' } }

        it 'destroys partner object' do
          expect { request }.to change { Partner.count }.by(-1)
        end

        it 'and redirects to partners path' do
          request

          expect(response).to redirect_to partners_en_path
        end
      end
    end

    def do_request
      delete :destroy, params: { id: 111, locale: 'en' }
    end
  end
end
