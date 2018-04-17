RSpec.describe EventsController, type: :controller do
  describe 'GET #index' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      it 'renders events#index' do
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

      context 'for invalid data event' do
        it 'renders new page' do
          post :create, params: { event: { name: 'admin' }, locale: 'en' }

          expect(response).to render_template :new
        end
      end

      context 'for valid event' do
        let(:request) { post :create, params: { event: { name: 'admin', label: '1', description: '2', link: '3' }, locale: 'en' } }

        it 'creates new event' do
          expect { request }.to change { Event.count }.by(1)
        end

        it 'and redirects to events path' do
          request

          expect(response).to redirect_to events_en_path
        end
      end
    end

    def do_request
      post :create, params: { event: {}, locale: 'en' }
    end
  end

  describe 'GET #edit' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for unexisted event' do
        it 'renders error page' do
          get :edit, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed event' do
        let!(:event) { create :event }

        it 'renders events#edit' do
          get :edit, params: { id: event.id, locale: 'en' }

          expect(response).to render_template :edit
        end
      end
    end

    def do_request
      get :edit, params: { id: 1, locale: 'en' }
    end
  end

  describe 'PATCH #update' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for unexisted event' do
        it 'renders error page' do
          patch :update, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed event' do
        let!(:event) { create :event }
        let(:request) { patch :update, params: { event: { name: 'admin' }, id: event.id, locale: 'en' } }

        it 'changes event object' do
          request
          event.reload

          expect(event.name).to eq 'admin'
        end

        it 'and redirects to events path' do
          request

          expect(response).to redirect_to events_en_path
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

      context 'for unexisted event' do
        it 'renders error page' do
          delete :destroy, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed event' do
        let!(:event) { create :event }
        let(:request) { delete :destroy, params: { id: event.id, locale: 'en' } }

        it 'destroys event object' do
          expect { request }.to change { Event.count }.by(-1)
        end

        it 'and redirects to events path' do
          request

          expect(response).to redirect_to events_en_path
        end
      end
    end

    def do_request
      delete :destroy, params: { id: 111, locale: 'en' }
    end
  end
end
