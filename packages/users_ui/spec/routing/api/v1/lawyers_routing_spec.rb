require 'rails_helper'

RSpec.describe Api::V1::LawyersController do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/api/v1/lawyers/1').to route_to('api/v1/lawyers#show', id: '1', format: 'json')
    end
  end
end
