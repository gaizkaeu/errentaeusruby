require 'rails_helper'

RSpec.describe 'OrganizationStats' do
  let(:organization) { create(:organization, status: 'featured_city') }
  let(:stat) { attributes_for(:organization_stat, organization_id: organization.id) }

  context 'when no authorized user' do
    describe 'INDEX /organization-manage/:id/stats' do
      it 'does not render a successful response' do
        get api_v1_organization_manage_stats_url(organization_manage_id: 1), as: :json
        expect(response).not_to be_successful
      end
    end
  end

  context 'when owner logged in' do
    before do
      sign_in organization.owner
    end

    describe 'INDEX /organization-manage/:id/stats' do
      it 'renders a successful response' do
        get api_v1_organization_manage_stats_url(organization_manage_id: organization.id), as: :json
        expect(response).to be_successful
      end

      it 'renders data' do
        stat_obj = Api::V1::Repositories::OrganizationStatRepository.add(stat, raise_error: true)
        get api_v1_organization_manage_stats_url(organization_manage_id: organization.id), as: :json
        expect(JSON.parse(response.body)['data']).to be_present
        expect(JSON.parse(response.body)['data'].first['id']).to eq(stat_obj.id)
      end

      context 'when query by date' do
        it 'renders data' do
          stat_obj = Api::V1::Repositories::OrganizationStatRepository.add(stat, raise_error: true)
          get api_v1_organization_manage_stats_url(organization_manage_id: organization.id, date_start: stat[:date]), as: :json
          expect(JSON.parse(response.body)['data']).to be_present
          expect(JSON.parse(response.body)['data'].first['id']).to eq(stat_obj.id)
          get api_v1_organization_manage_stats_url(organization_manage_id: organization.id, date_end: stat[:date]), as: :json
          expect(JSON.parse(response.body)['data']).to be_present
          expect(JSON.parse(response.body)['data'].first['id']).to eq(stat_obj.id)
          get api_v1_organization_manage_stats_url(organization_manage_id: organization.id, date_end: '02-03-2002'), as: :json
          expect(JSON.parse(response.body)['data']).not_to be_present
        end
      end
    end
  end
end
