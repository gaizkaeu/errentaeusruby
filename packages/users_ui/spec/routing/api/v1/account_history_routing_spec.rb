require 'rails_helper'

RSpec.describe Api::V1::AccountHistoryController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/accounts/1/history').to route_to('api/v1/account_history#index', format: 'json', id: "1")
    end
  end
end
