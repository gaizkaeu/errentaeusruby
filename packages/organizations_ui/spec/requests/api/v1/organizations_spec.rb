require 'rails_helper'

RSpec.describe 'Organizations' do
  context 'when no logged in user' do
    let(:user) { create(:user) }
    let(:organization) { create(:organization, owner_id: user.id, status: 'featured_city') }
    let(:organization2) { create(:organization, owner_id: user.id, status: 'not_subscribed') }

    describe 'INDEX /organizations' do
      it 'does not show not subscribed organizations' do
        Api::V1::Repositories::OrganizationRepository.add(organization2.attributes)
        Api::V1::Repositories::OrganizationRepository.add(organization.attributes)
        get api_v1_organizations_url, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].map { |o| o['attributes']['id'] }).not_to include(organization2.id)
      end

      it 'shows featured organizations' do
        Api::V1::Repositories::OrganizationRepository.add(organization2.attributes)
        Api::V1::Repositories::OrganizationRepository.add(organization.attributes)
        get api_v1_organizations_url, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].pluck('id')).to include(organization.id)
      end
    end

    describe 'SHOW /organizations/:id' do
      it 'renders a successful response' do
        get api_v1_organization_url(organization2.id), as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data']['attributes'].symbolize_keys!).to match(a_hash_including(organization2.attributes.slice(:name)))
      end

      # TODO: do not show not subscribed organizations
      # it 'does not show not subscribed organizations' do
      #   get api_v1_organization_url(organization2.id), as: :json
      #   expect(response).to have_http_status(:not_found)
      # end
    end
  end
end
