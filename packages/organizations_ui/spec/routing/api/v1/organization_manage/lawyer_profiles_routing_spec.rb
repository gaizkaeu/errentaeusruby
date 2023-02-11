require 'rails_helper'

RSpec.describe Api::V1::OrganizationManage::LawyerProfilesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/organization-manage/1/lawyer_profiles').to route_to('api/v1/organization_manage/lawyer_profiles#index', organization_manage_id: '1', format: 'json')
    end
  end
end
