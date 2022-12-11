require 'rails_helper'

RSpec.describe Api::V1::EstimationsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/estimations').to route_to('api/v1/estimations#index', format: 'json')
    end

    it 'routes to #estimate' do
      expect(post: '/api/v1/estimations/estimate').to route_to('api/v1/estimations#estimate', format: 'json')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/estimations/1').to route_to('api/v1/estimations#show', id: '1', format: 'json')
    end

    it 'routes to #estimation_from_jwt' do
      expect(post: '/api/v1/estimations/estimation_from_jwt').to route_to('api/v1/estimations#estimation_from_jwt', format: 'json')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/estimations/1').to route_to('api/v1/estimations#update', id: '1', format: 'json')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/estimations/1').to route_to('api/v1/estimations#update', id: '1', format: 'json')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/estimations/1').to route_to('api/v1/estimations#destroy', id: '1', format: 'json')
    end
  end
end
