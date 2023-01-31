require 'rails_helper'

RSpec.describe 'Organizations' do
  context 'when logged in lawyer' do
    let(:user) { create(:user) }
    let(:lawyer) { create(:lawyer) }
    let(:organization) { create(:organization, owner_id: lawyer.id) }

    before do
      sign_in(lawyer)
    end

    describe 'INDEX /organizations' do
      it 'renders a successful response' do
        authorized_get api_v1_organizations_url, as: :json
        expect(response).to be_successful
      end
    end

    describe 'SHOW /organizations/:id' do
      it 'renders a successful response' do
        authorized_get api_v1_organization_url(organization.id), as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data']['attributes'].symbolize_keys!).to match(a_hash_including(organization.attributes.slice(:name)))
      end
    end
  end
end
