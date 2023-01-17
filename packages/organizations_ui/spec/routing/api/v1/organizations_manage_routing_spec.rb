require 'rails_helper'

RSpec.describe Api::V1::OrganizationManageController do
  describe 'routing' do
    it 'routes to #accept' do
      expect(post: '/api/v1/organizations/1/manage/accept/2').to route_to('api/v1/organization_manage#accept', organization_id: '1', lawyer_profile_id: '2', format: 'json')
    end

    it 'routes to #reject' do
      expect(post: '/api/v1/organizations/1/manage/reject/2').to route_to('api/v1/organization_manage#reject', organization_id: '1', lawyer_profile_id: '2', format: 'json')
    end

    it 'routes to #lawyers' do
      expect(get: '/api/v1/organizations/1/manage/lawyers').to route_to('api/v1/organization_manage#lawyers', organization_id: '1', format: 'json')
    end
  end
end
