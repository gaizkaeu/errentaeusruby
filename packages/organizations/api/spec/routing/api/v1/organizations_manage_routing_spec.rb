require 'rails_helper'

RSpec.describe Api::V1::OrganizationManageController do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/api/v1/organization-manage').to route_to('api/v1/organization_manage#create', format: 'json')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/organization-manage/1').to route_to('api/v1/organization_manage#update', id: '1', format: 'json')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/organization-manage/1').to route_to('api/v1/organization_manage#update', id: '1', format: 'json')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/organization-manage/1').to route_to('api/v1/organization_manage#destroy', id: '1', format: 'json')
    end
  end
end
