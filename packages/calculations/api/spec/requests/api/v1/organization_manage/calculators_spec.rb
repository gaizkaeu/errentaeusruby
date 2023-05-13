require 'rails_helper'

RSpec.describe 'OrganizationManage/Calculators' do
  let(:user) { create(:user) }
  let(:organization) { create(:organization, :with_memberships) }
  let(:calculator) { create(:calculator, :calct_test_schema, organization:) }

  context 'with owning organization' do
    before do
      sign_in organization.memberships.first.user
    end

    describe 'INDEX /organization-manage/:id/calculators' do
      it 'renders a successful response' do
        c = build(:calculator, :calct_test_schema, organization:)
        c.save!
        authorized_get api_v1_org_man_clcr_index_url(organization.id), as: :json
        expect(response).to be_successful
        expect(body).to be_present
        expect(JSON.parse(body)['data'].first['id']).to eq(c.id)
        expect(JSON.parse(body)['data'].length).to eq(1)
      end
    end

    describe 'SHOW /organization-manage/:id/calculators/:id' do
      it 'renders a successful response' do
        authorized_get api_v1_org_man_clcr_url(organization.id, calculator.id), as: :json
        expect(response).to be_successful
        expect(body).to be_present
        expect(JSON.parse(body)['data']['id']).to eq(calculator.id)
      end
    end

    describe 'UPDATE /organization-manage/:id/calculators/:id' do
      it 'updates allowed attributes' do
        authorized_patch api_v1_org_man_clcr_url(organization.id, calculator.id), params: { classifications: { prueba: '2*trabajadores' } }, as: :json
        expect(response).to be_successful
        expect(body).to be_present
        expect(JSON.parse(body)['data']['id']).to eq(calculator.id)
        expect(JSON.parse(body)['data']['attributes']['classifications']['prueba']).to eq('2*trabajadores')
      end

      it 'does not update unallowed attributes' do
        authorized_patch api_v1_org_man_clcr_url(organization.id, calculator.id), params: { classifications: { prueba: '2*trabajadores' }, calculator_status: 'test' }, as: :json
        expect(response).to be_successful
        expect(body).to be_present
        expect(JSON.parse(body)['data']['id']).to eq(calculator.id)
        expect(JSON.parse(body)['data']['attributes']['classifications']['prueba']).to eq('2*trabajadores')
        expect(JSON.parse(body)['data']['attributes']['calculator_status']).not_to eq('test')
      end
    end

    describe 'TRAIN /organization-manage/:id/calculators/:id/train' do
      it 'trains the calculator' do
        expect do
          authorized_post train_api_v1_org_man_clcr_url(organization.id, calculator.id), as: :json
        end.to enqueue_job(CalcrTrainJob)
        expect(response).to be_successful
        expect(body).to be_present
      end

      it 'renders a JSON response with errors' do
        calculator.update!(last_trained_at: Time.zone.now)

        expect do
          authorized_post train_api_v1_org_man_clcr_url(organization.id, calculator.id), as: :json
        end.not_to enqueue_job(CalcrTrainJob)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(body).to be_present
      end
    end
  end

  context 'with no signed_in account' do
    describe 'INDEX /organization-manage/:id/calculators' do
      it 'renders a error response' do
        get api_v1_org_man_clcr_index_url(organization.id), as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  context 'with non-owning organization' do
    before do
      user = create(:user)
      user.save!
      sign_in user
    end

    describe 'INDEX /organization-manage/:id/calculators' do
      it 'renders a error response' do
        get api_v1_org_man_clcr_index_url(organization.id), as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
