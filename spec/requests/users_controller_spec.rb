require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get '/users'
      expect(response).to render_template('users/index')
    end

    it 'should include the placeholder' do
      get '/users'
      expect(response.body).to include('List all users')
    end
  end

  describe 'GET / show' do
    it 'should be a successfull respose for specfic id' do
      get '/users/:id'
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get '/users/:id'
      expect(response).to render_template(:show)
    end

    it 'should include the placeholder' do
      get '/users/:id'
      expect(response.body).to include('Show a user')
    end
  end
end
