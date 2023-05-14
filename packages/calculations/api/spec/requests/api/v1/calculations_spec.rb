require 'rails_helper'

RSpec.describe 'Calculations' do
  let(:user) { create(:user) }
  let(:organization) { create(:organization, :with_memberships) }
  let(:calculator) { create(:calculator, :calct_test_schema, organization:) }
  let(:calculation) { create(:calculation, :calct_test_schema, calculator:, user:) }

  context 'with authorized user' do
    before do
      sign_in user
    end

    describe 'SHOW /calculations/:id' do
      it 'renders a successful response' do
        authorized_get api_v1_calculation_url(calculation.id), as: :json
        expect(response).to be_successful
        expect(body).to be_present
        expect(JSON.parse(body)['data']['id']).to eq(calculation.id)
        expect(JSON.parse(body)['data']['attributes']['input']).to eq(calculation.input.transform_values(&:to_s))
      end

      it 'cannot access other user calculations' do
        s = create(:calculation, :calct_test_schema, calculator:)
        authorized_get api_v1_calculation_url(s.id), as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'CREATE /calculations' do
      it 'creates a new Calculation' do
        s = build(:calculation, :calct_test_schema, calculator:)

        expect do
          authorized_post api_v1_calculations_url, params: { calculation: s.attributes }, as: :json
        end.to change(Api::V1::Calculation, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(body).to be_present
        expect(JSON.parse(body)['data']['attributes']['input']).to eq(s.input.transform_values(&:to_s))
      end

      it 'cannot put privileged attributes' do
        s = build(:calculation, :calct_test_schema, calculator:, train_with: true, user_id: 2)

        expect do
          authorized_post api_v1_calculations_url, params: { calculation: s.attributes }, as: :json
        end.to change(Api::V1::Calculation, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(body).to be_present
        expect(JSON.parse(body)['data']['attributes']['input']).to eq(s.input.transform_values(&:to_s))

        id = JSON.parse(body)['data']['id']

        expect(Api::V1::Calculation.find(id).train_with).to be(false)
        expect(Api::V1::Calculation.find(id).user_id).to eq(user.id)
      end

      it 'enqueues prediction job' do
        s = build(:calculation, :calct_test_schema, calculator:)
        expect do
          authorized_post api_v1_calculations_url, params: { calculation: s.attributes }, as: :json
        end.to enqueue_job(CalcrPredictJob)
      end

      it 'renders errors when invalid' do
        s = build(:calculation, :calct_test_schema, calculator:, input: { 'a' => 'b' })
        authorized_post api_v1_calculations_url, params: { calculation: s.attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(body).to be_present
        expect(JSON.parse(body)['errors']).to be_present
      end
    end

    describe 'BULK /calculations/:id/bulk' do
      it 'creates a new BulkCalculation from Calculation' do
        expect do
          authorized_post bulk_api_v1_calculation_url(calculation.id), as: :json
        end.to change(Api::V1::BulkCalculation, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(body).to be_present
        expect(JSON.parse(body)['data']['attributes']['input']).to eq(calculation.input.transform_values(&:to_s))
      end

      it 'does not create a new BulkCalculation from Calculation if already exists' do
        expect do
          authorized_post bulk_api_v1_calculation_url(calculation.id), as: :json
          authorized_post bulk_api_v1_calculation_url(calculation.id), as: :json
        end.to change(Api::V1::BulkCalculation, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(body).to be_present
        expect(JSON.parse(body)['data']['attributes']['input']).to eq(calculation.input.transform_values(&:to_s))
      end
    end
  end
end
