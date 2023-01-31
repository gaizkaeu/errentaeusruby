require 'rails_helper'

RSpec.describe Api::V1::OrganizationManageController do
  describe 'routing' do
    it 'routes to #accept' do
      expect(post: '/api/v1/organization-manage/1/lawyer-profiles/2/accept').to route_to('api/v1/organization_lawyers#accept', organization_manage_id: '1', id: '2', format: 'json')
    end

    it 'routes to #reject' do
      expect(post: '/api/v1/organization-manage/1/lawyer-profiles/2/remove').to route_to('api/v1/organization_lawyers#remove', organization_manage_id: '1', id: '2', format: 'json')
    end

    it 'routes to #index' do
      expect(get: '/api/v1/organization-manage/1/lawyer-profiles').to route_to('api/v1/organization_lawyers#index', organization_manage_id: '1', format: 'json')
    end
  end
end
