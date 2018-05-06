RSpec.describe MembersController, type: :controller do
  describe 'GET #index' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      it 'renders memebers#index' do
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

      context 'for valid member' do
        let(:request) { post :create, params: { member: { name: 'admin', title: '2', user_id: @current_user.id }, locale: 'en' } }

        it 'creates new member' do
          expect { request }.to change { Member.count }.by(1)
        end

        it 'and redirects to edit member path' do
          request

          expect(response).to redirect_to edit_member_en_path(Member.last)
        end
      end
    end

    def do_request
      post :create, params: { member: {}, locale: 'en' }
    end
  end

  describe 'GET #edit' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for unexisted member' do
        it 'renders error page' do
          get :edit, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed member' do
        let!(:member) { create :member }

        it 'renders partners#edit' do
          get :edit, params: { id: member.id, locale: 'en' }

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

      context 'for unexisted member' do
        it 'renders error page' do
          patch :update, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed member' do
        let!(:member) { create :member }
        let(:request) { patch :update, params: { member: { name: 'admin' }, id: member.id, locale: 'en' } }

        it 'changes member object' do
          request
          member.reload

          expect(member.name).to eq 'admin'
        end

        it 'and redirects to members path' do
          request

          expect(response).to redirect_to members_en_path
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

      context 'for unexisted member' do
        it 'renders error page' do
          delete :destroy, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed member' do
        let!(:member) { create :member }
        let(:request) { delete :destroy, params: { id: member.id, locale: 'en' } }

        it 'destroys member object' do
          expect { request }.to change { Member.count }.by(-1)
        end

        it 'and redirects to members path' do
          request

          expect(response).to redirect_to members_en_path
        end
      end
    end

    def do_request
      delete :destroy, params: { id: 111, locale: 'en' }
    end
  end

  describe 'GET #clear_credit' do
    it_behaves_like 'Admin Auth'

    context 'for admins' do
      sign_in_admin

      context 'for unexisted member' do
        it 'renders error page' do
          get :clear_credit, params: { id: 111, locale: 'en' }

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for existed member' do
        let!(:member) { create :member }
        let(:request) { get :clear_credit, params: { id: member.id, locale: 'en' } }

        it 'calls clear basket' do
          expect_any_instance_of(Basket).to receive(:clear)

          request
        end

        it 'and redirects to members path' do
          request

          expect(response).to redirect_to members_en_path
        end
      end
    end

    def do_request
      get :clear_credit, params: { id: 999, locale: 'en' }
    end
  end
end
