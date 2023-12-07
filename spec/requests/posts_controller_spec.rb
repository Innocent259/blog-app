RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get '/users/:id/posts'
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get '/users/:id/posts'
      expect(response).to render_template(:index)
    end

    it 'should include the placeholder' do
      get '/users/:id/posts'
      expect(response.body).to include('User posts')
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      get '/users/:id/posts/:id'
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get '/users/:id/posts/:id'
      expect(response).to render_template('posts/show')
    end

    it 'should include the placeholder' do
      get '/users/:id/posts/:id'
      expect(response.body).to include('Single post')
    end
  end
end
