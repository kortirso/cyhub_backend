RSpec.describe PhotosController, type: :controller do
  describe 'GET #index' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      it 'renders photos#index' do
        get :index, params: { locale: 'en' }

        expect(response).to render_template :index
      end
    end

    def do_request
      get :index, params: { locale: 'en' }
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for unexisted photo' do
        it 'renders error page' do
          delete :destroy, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed photo' do
        let!(:photo) { create :photo }
        let(:request) { delete :destroy, params: { id: photo.id, locale: 'en' } }

        it 'destroys photo object' do
          expect { request }.to change { Photo.count }.by(-1)
        end

        it 'and redirects to photos path' do
          request

          expect(response).to redirect_to photos_en_path
        end
      end
    end

    def do_request
      delete :destroy, params: { id: 111, locale: 'en' }
    end
  end
end
