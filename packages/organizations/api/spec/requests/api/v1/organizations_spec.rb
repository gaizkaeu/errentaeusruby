require 'rails_helper'

RSpec.describe 'Organizations' do
  context 'when no logged in user' do
    let(:user) { create(:user) }
    let(:organization) { create(:organization, status: 'featured_city') }
    let(:organization2) { create(:organization, status: 'not_subscribed') }

    describe 'INDEX /organizations' do
      it 'shows organizations' do
        Api::V1::Organization.create!(organization2.attributes)
        Api::V1::Organization.create!(organization.attributes)
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
    end
  end
end
