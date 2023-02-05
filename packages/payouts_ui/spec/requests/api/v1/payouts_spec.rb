require 'rails_helper'

RSpec.describe 'Payouts' do
  let(:org_manage) { create(:org_manage) }
  let(:admin) { create(:admin) }
  let(:organization) { create(:organization, owner_id: org_manage.id) }

  context 'when logged in admin' do
    before do
      sign_in(admin)
    end

    describe 'index /' do
      it 'renders a successful response' do
        Api::V1::Repositories::PayoutRepository.add(attributes_for(:payout, organization_id: organization.id))
        authorized_get api_v1_payouts_url, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].size).to eq(1)
      end
    end
  end

  context 'when logged in org_manage' do
    before do
      sign_in(org_manage)
    end

    describe 'index /' do
      it 'user can only query his payouts' do
        create_list(:payout, 5)
        Api::V1::Repositories::PayoutRepository.add(attributes_for(:payout, organization_id: organization.id))

        authorized_get api_v1_payouts_url, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].size).to eq(1)
      end
    end
  end
end
