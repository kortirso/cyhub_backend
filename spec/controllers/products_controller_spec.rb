RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      it 'renders products#index' do
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

      context 'for invalid data' do
        it 'renders new page' do
          post :create, params: { product: { price: -100 }, locale: 'en' }

          expect(response).to render_template :new
        end
      end

      context 'for valid data' do
        let(:request) { post :create, params: { product: { name: 'Snickers', price: 1 }, locale: 'en' } }

        it 'creates new product' do
          expect { request }.to change { Product.count }.by(1)
        end

        it 'and redirects to products path' do
          request

          expect(response).to redirect_to products_en_path
        end
      end
    end

    def do_request
      post :create, params: { product: {}, locale: 'en' }
    end
  end

  describe 'GET #edit' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for unexisted product' do
        it 'renders error page' do
          get :edit, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed product' do
        let!(:product) { create :product }

        it 'renders products#edit' do
          get :edit, params: { id: product.id, locale: 'en' }

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

      context 'for unexisted product' do
        it 'renders error page' do
          patch :update, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed product' do
        let!(:product) { create :product }
        let(:request) { patch :update, params: { product: { name: 'Sprite' }, id: product.id, locale: 'en' } }

        it 'changes product object' do
          request
          product.reload

          expect(product.name).to eq 'Sprite'
        end

        it 'and redirects to products path' do
          request

          expect(response).to redirect_to products_en_path
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

      context 'for unexisted product' do
        it 'renders error page' do
          delete :destroy, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed product' do
        let!(:product) { create :product }
        let(:request) { delete :destroy, params: { id: product.id, locale: 'en' } }

        it 'destroys product object' do
          expect { request }.to change { Product.count }.by(-1)
        end

        it 'and redirects to events path' do
          request

          expect(response).to redirect_to products_en_path
        end
      end
    end

    def do_request
      delete :destroy, params: { id: 111, locale: 'en' }
    end
  end
end
