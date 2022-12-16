require 'rails_helper'

RSpec.describe Api::V1::Auth::RefreshController do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/api/v1/auth/refresh').to route_to('api/v1/auth/refresh#create', format: 'json')
    end
  end
end
