require 'rails_helper'

RSpec.describe Api::V1::WebauthnController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/accounts/1/webauthn_keys').to route_to('api/v1/webauthn#index', format: 'json', id: '1')
    end
  end
end
