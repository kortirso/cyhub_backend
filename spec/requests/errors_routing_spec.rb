RSpec.describe 'Request errors' do
  describe 'routing' do
    it 'renders error page for error path' do
      get '/1'

      expect(response).to render_template 'shared/404'
    end
  end
end
