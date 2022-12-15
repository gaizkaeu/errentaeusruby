require 'rails_helper'

RSpec.describe Api::V1::Auth::SessionsController do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/api/v1/auth/sign_in').to route_to('api/v1/auth/sessions#create', format: 'json')
    end

    it 'routes to #google' do
      expect(post: '/api/v1/auth/google').to route_to('api/v1/auth/sessions#google', format: 'json')
    end

    it 'routes to #logout' do
      expect(delete: '/api/v1/auth/logout').to route_to('api/v1/auth/sessions#destroy', format: 'json')
    end

    it 'routes to #me' do
      expect(get: '/api/v1/auth/me').to route_to('api/v1/auth/sessions#me', format: 'json')
    end
  end
end
