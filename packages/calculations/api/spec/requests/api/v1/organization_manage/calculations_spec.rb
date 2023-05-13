require 'rails_helper'

RSpec.describe 'OrganizationManage/Calculations' do
  let(:user) { create(:user) }
  let(:organization) { create(:organization, :with_memberships) }
  let(:calculator) { create(:calculator, :calct_test_schema, organization:) }

  context 'with owning organization' do
    before do
      sign_in organization.memberships.first.user
    end

    describe 'INDEX /organization-manage/:id/calculators' do
      it 'renders a successful response' do
        c = build(:calculation, :calct_test_schema, calculator:)
        c.save!
        authorized_get api_v1_org_man_clcr_clcn_index_url(organization.id, calculator.id), as: :json
        expect(response).to be_successful
        expect(body).to be_present
        expect(JSON.parse(body)['data'].first['id']).to eq(c.id)
        expect(JSON.parse(body)['data'].length).to eq(1)
      end
    end
  end
end
