require 'rails_helper'

RSpec.describe Api::V1::OrganizationManage::TaxIncomesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/organization-manage/1/tax_incomes').to route_to('api/v1/organization_manage/tax_incomes#index', organization_manage_id: '1', format: 'json')
    end
  end
end
