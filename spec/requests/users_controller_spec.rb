require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: 1 }
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get :show, params: { id: 1 }
      expect(response).to render_template('show')
    end
  end
end
