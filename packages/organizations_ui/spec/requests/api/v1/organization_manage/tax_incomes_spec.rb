require 'rails_helper'

RSpec.describe 'OrganizationManageTaxIncomes' do
  let(:user) { create(:user) }
  let(:org_manage) { create(:org_manage) }
  let(:organization) { create(:organization, status: 'featured_city', name: 'hola', owner_id: org_manage.id) }
  let(:organization2) { create(:organization, status: 'featured_city', name: '2hola') }

  context 'when not authorized user' do
    before do
      sign_in user
    end

    it 'does not render a successful response' do
      authorized_get api_v1_organization_manage_tax_incomes_url(organization_manage_id: organization.id), as: :json
      expect(response).not_to be_successful
      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'with org_manage user' do
    before do
      sign_in organization.owner
    end

    it 'renders a successful response' do
      authorized_get api_v1_organization_manage_tax_incomes_url(organization_manage_id: organization.id), as: :json
      expect(response).to be_successful
      expect(body['data']).to be_present
    end

    it 'can show only authorized organization tax_incomes' do
      create(:tax_income, organization:)
      create(:tax_income, organization: organization2)

      authorized_get api_v1_organization_manage_tax_incomes_url(organization_manage_id: organization2.id), as: :json

      expect(response).not_to be_successful
      expect(response).to have_http_status(:forbidden)
    end

    it 'shows tax_incomes' do
      t = create(:tax_income, organization:)
      authorized_get api_v1_organization_manage_tax_incomes_url(organization_manage_id: organization.id), as: :json
      expect(response).to be_successful
      expect(body['data']).to be_present
      expect(JSON.parse(response.body)['data'].first['id']).to eq(t.id)
    end

    it 'shows correct tax_incomes' do
      t = create(:tax_income, organization:)
      create(:tax_income, organization: organization2)
      authorized_get api_v1_organization_manage_tax_incomes_url(organization_manage_id: organization.id), as: :json
      expect(response).to be_successful
      expect(body['data']).to be_present
      expect(JSON.parse(response.body)['data'].size).to eq(1)
      expect(JSON.parse(response.body)['data'].first['id']).to eq(t.id)
    end
  end
end
