require 'rails_helper'

RSpec.describe Api::V1::OrganizationStatsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/organization-manage/1/stats').to route_to('api/v1/organization_stats#index', organization_manage_id: '1', format: 'json')
    end
  end
end
