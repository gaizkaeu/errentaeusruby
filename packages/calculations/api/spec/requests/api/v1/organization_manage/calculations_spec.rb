require 'rails_helper'

RSpec.describe 'OrganizationManage/Calculations' do
  let(:user) { create(:user) }
  let(:organization) { create(:organization, :with_memberships) }
  let(:calculator) { create(:calculator, :calct_test_schema, organization:) }
  let(:calculation) { create(:calculation, :calct_test_schema, calculator:) }

  context 'with owning organization' do
    before do
      sign_in organization.memberships.first.user
    end

    describe 'INDEX /organization-manage/:id/calculators/calculations' do
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

    describe 'SHOW /organization-manage/:id/calculators/calculations/:id' do
      it 'renders a successful response' do
        authorized_get api_v1_org_man_clcr_clcn_url(organization.id, calculator.id, calculation.id), as: :json
        expect(response).to be_successful
        expect(body).to be_present
        expect(JSON.parse(body)['data']['id']).to eq(calculation.id)
        expect(JSON.parse(body)['data']['attributes']['input']).to eq(calculation.input.transform_values(&:to_s))
      end
    end

    describe 'CREATE /organization-manage/:id/calculators/calculations' do
      it 'creates a new Calculation' do
        s = build(:calculation, :calct_test_schema, calculator:)

        expect do
          authorized_post api_v1_org_man_clcr_clcn_index_url(organization.id, calculator.id), params: { calculation: s.attributes }, as: :json
        end.to change(Api::V1::Calculation, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(body).to be_present
        expect(JSON.parse(body)['data']['attributes']['input']).to eq(s.input.transform_values(&:to_s))
      end

      it 'renders a JSON response with errors for the new calculation' do
        s = build(:calculation, :calct_test_schema, calculator:)

        s.input = nil

        expect do
          authorized_post api_v1_org_man_clcr_clcn_index_url(organization.id, calculator.id), params: { calculation: s.attributes }, as: :json
        end.not_to change(Api::V1::Calculation, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(body).to be_present
        expect(JSON.parse(body)['input']).to include("can't be blank")
      end
    end

    describe 'UPDATE /organization-manage/:id/calculators/calculations/:id' do
      it 'updates the requested calculation' do
        s = build(:calculation, :calct_test_schema, calculator:)
        s.save!

        new_input = { 'constitucion' => 'sociedad', 'trabajadores' => 5, 'impuestos_especiales' => true }

        authorized_put api_v1_org_man_clcr_clcn_url(organization.id, calculator.id, s.id), params: { calculation: { input: new_input } }, as: :json

        s.reload
        expect(response).to have_http_status(:ok)
        expect(body).to be_present
        expect(JSON.parse(body)['data']['attributes']['input']).to eq(new_input.transform_values(&:to_s))
        expect(s.input).to eq(new_input)
      end

      it 'renders a JSON response with errors for the calculation' do
        s = build(:calculation, :calct_test_schema, calculator:)
        s.save!

        new_input = { 'constitucion' => 'socied1ad', 'trabajadores' => 5, 'impuestos_especiales' => true }
        authorized_put api_v1_org_man_clcr_clcn_url(organization.id, calculator.id, s.id), params: { calculation: { input: new_input } }, as: :json
        s.reload
        expect(response).to have_http_status(:unprocessable_entity)
        expect(body).to be_present
        expect(s.input).not_to eq(new_input)
      end
    end

    describe 'DELETE /organization-manage/:id/calculators/calculations/:id' do
      it 'destroys the requested calculation' do
        s = build(:calculation, :calct_test_schema, calculator:)
        s.save!

        expect do
          authorized_delete api_v1_org_man_clcr_clcn_url(organization.id, calculator.id, s.id), as: :json
        end.to change(Api::V1::Calculation, :count).by(-1)
      end
    end
  end

  context 'with non-owning organization' do
    before do
      sign_in create(:user)
    end

    describe 'INDEX /organization-manage/:id/calculators/calculations' do
      it 'renders a forbidden response' do
        authorized_get api_v1_org_man_clcr_clcn_index_url(organization.id, calculator.id), as: :json

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  context 'with not authenticated' do
    describe 'INDEX /organization-manage/:id/calculators/calculations' do
      it 'renders a forbidden response' do
        authorized_get api_v1_org_man_clcr_clcn_index_url(organization.id, calculator.id), as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
