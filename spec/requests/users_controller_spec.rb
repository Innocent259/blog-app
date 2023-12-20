require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create(name: 'Test User')
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create(name: 'Test User')
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end
end
