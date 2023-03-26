require 'rails_helper'

RSpec.describe Api::V1::OrganizationsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/organizations').to route_to('api/v1/organizations#index', format: 'json')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/organizations/1').to route_to('api/v1/organizations#show', id: '1', format: 'json')
    end
  end
end
