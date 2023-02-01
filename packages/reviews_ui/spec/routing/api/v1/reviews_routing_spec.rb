require 'rails_helper'

RSpec.describe Api::V1::ReviewsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/reviews').to route_to('api/v1/reviews#index', format: 'json')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/reviews').to route_to('api/v1/reviews#create', format: 'json')
    end
  end
end
