require 'rails_helper'

RSpec.describe Api::V1::OrganizationManage::StatsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(post: '/api/v1/organization-manage/1/subscription').to route_to('api/v1/organization_subscription#create', organization_manage_id: '1', format: 'json')
    end
  end
end
