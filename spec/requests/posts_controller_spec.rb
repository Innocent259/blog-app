require 'rails_helper'

describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      user = User.create(name: 'Test User')

      get :index, params: { user_id: user.id }
      expect(response).to be_successful
    end

    it 'renders the index template' do
      user = User.create(name: 'Test User')

      get :index, params: { user_id: user.id }
      expect(response).to render_template(:index)
    end
  end
end