require 'rails_helper'

RSpec.describe Api::V1::AccountsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/accounts').to route_to('api/v1/accounts#index', format: 'json')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/accounts/1').to route_to('api/v1/accounts#show', id: '1', format: 'json')
    end

    it 'routes to #resend_confirmation' do
      expect(post: '/api/v1/accounts/1/resend_confirmation').to route_to('api/v1/accounts#resend_confirmation', id: '1', format: 'json')
    end

    it 'routes to #me' do
      expect(get: '/api/v1/accounts/me').to route_to('api/v1/accounts#me', format: 'json')
    end

    it 'routes to #update' do
      expect(put: '/api/v1/accounts/1').to route_to('api/v1/accounts#update', format: 'json', id: '1')
    end
  end
end
