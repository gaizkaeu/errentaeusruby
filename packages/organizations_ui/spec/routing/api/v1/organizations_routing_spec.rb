require 'rails_helper'

RSpec.describe Api::V1::OrganizationsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/organizations').to route_to('api/v1/organizations#index', format: 'json')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/organizations/1').to route_to('api/v1/organizations#show', id: '1', format: 'json')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/organizations').to route_to('api/v1/organizations#create', format: 'json')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/organizations/1').to route_to('api/v1/organizations#update', id: '1', format: 'json')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/organizations/1').to route_to('api/v1/organizations#update', id: '1', format: 'json')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/organizations/1').to route_to('api/v1/organizations#destroy', id: '1', format: 'json')
    end

    it 'routes to #lawyers' do
      expect(get: '/api/v1/organizations/1/lawyers').to route_to('api/v1/organizations#lawyers', id: '1', format: 'json')
    end
  end
end
