require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/api/v1/tax_incomes' do
  let(:user) { create(:user) }
  let(:lawyer) { create(:lawyer) }

  let(:valid_attributes) do
    { observations: 'this is a test', client_id: user.id }
  end

  let(:invalid_attributes) do
    { observations: 3, id: 4 }
  end

  context 'with estimation integration' do
    before do
      sign_in(user)
    end

    let(:valid_attributes) do
      { observations: 'this is a test', client_id: user.id }
    end

    let(:estimation_params) do
      {
        first_name: 'Gaizka',
        first_time: false,
        home_changes: 0,
        rentals_mortgages: 0,
        professional_company_activity: false,
        real_state_trade: 0,
        with_couple: false,
        income_rent: 0,
        shares_trade: 0,
        outside_alava: false
      }
    end

    it 'creates a tax income with new estimation' do
      post estimate_api_v1_estimations_url, params: { estimation: estimation_params }
      token = JSON.parse(response.body)['token']['data']

      expect do
        authorized_post api_v1_tax_incomes_url, params: { tax_income: valid_attributes, estimation: { token: } }
      end.to change(Api::V1::TaxIncome, :count).by(1)
      expect(response).to be_successful
      expect(Api::V1::TaxIncome.last.estimation).not_to be_nil
      expect(Api::V1::TaxIncome.last.estimation.attributes.symbolize_keys!).to match(a_hash_including(estimation_params))
    end

    it 'creates a tax income with invalid estimation' do
      post estimate_api_v1_estimations_url, params: { estimation: estimation_params }
      token = "#{JSON.parse(response.body)['token']['data']}hahaha invalidating jwt"

      expect do
        authorized_post api_v1_tax_incomes_url, params: { tax_income: valid_attributes, estimation: { token: } }
      end.to change(Api::V1::TaxIncome, :count).by(1)
      expect(Api::V1::TaxIncome.last.estimation).to be_nil
    end
  end

  context 'with lawyer access assigned' do
    let(:valid_attributes) do
      { observations: 'this is a test', client_id: user.id, lawyer_id: lawyer.id }
    end

    before do
      sign_in(lawyer)
    end

    describe 'GET /index authenticated' do
      it 'renders a successful response' do
        Api::V1::TaxIncome.create! valid_attributes
        authorized_get api_v1_tax_incomes_url
        expect(response).to be_successful
      end
    end

    describe 'GET /show authenticated' do
      it 'renders a successful response' do
        tax_income = Api::V1::TaxIncome.create! valid_attributes
        authorized_get api_v1_tax_income_url(tax_income)
        expect(response).to be_successful
      end
    end

    describe 'POST /create authenticated' do
      it 'creates a new Api::V1::TaxIncome to specified user' do
        expect do
          authorized_post api_v1_tax_incomes_url, params: { tax_income: valid_attributes, estimation: { token: nil } }
        end.to change(Api::V1::TaxIncome, :count).by(1)
        expect(Api::V1::TaxIncome.last!.client_id).to match(user.id)
      end

      it 'does not create new Api::V1::TaxIncome to lawyer' do
        expect do
          authorized_post api_v1_tax_incomes_url, params: { tax_income: valid_attributes.merge(client_id: lawyer.id), estimation: { token: nil } }
        end.not_to change(Api::V1::TaxIncome, :count)
      end
    end
  end

  context 'with lawyer access not assigned' do
    let(:valid_attributes) do
      { observations: 'this is a test', client_id: user.id, lawyer_id: lawyer.id }
    end

    describe 'GET /index authenticated' do
      before do
        sign_in(lawyer)
      end

      it 'renders a successful response' do
        Api::V1::TaxIncome.create! valid_attributes
        authorized_get api_v1_tax_incomes_url
        expect(response).to be_successful
      end
    end

    describe 'GET /show authenticated' do
      let(:evil_lawyer) { create(:lawyer) }

      before do
        sign_in(evil_lawyer)
      end

      it 'renders a successful response' do
        tax_income = Api::V1::TaxIncome.create! valid_attributes
        authorized_get api_v1_tax_income_url(tax_income)
        expect(response).not_to be_successful
      end
    end
  end

  context 'with user with no access' do
    let(:evil) { create(:user) }

    before do
      sign_in(evil)
    end

    it 'can index assigned tax incomes' do
      Api::V1::TaxIncome.create! valid_attributes
      authorized_get api_v1_tax_incomes_url
      expect(response).to be_successful
    end

    it 'can not see other tax incomes' do
      tax_income = Api::V1::TaxIncome.create! valid_attributes
      authorized_get api_v1_tax_income_url(tax_income)
      expect(response).not_to be_successful
      expect(response.body).to match('not found')
    end
  end

  context 'with authenticated user' do
    let(:evil) { create(:user) }

    before do
      sign_in(user)
    end

    describe 'GET /index' do
      it 'renders a successful response' do
        Api::V1::TaxIncome.create! valid_attributes
        authorized_get api_v1_tax_incomes_url
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        tax_income = Api::V1::TaxIncome.create! valid_attributes
        authorized_get api_v1_tax_income_url(tax_income)
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Api::V1::TaxIncome' do
          expect do
            authorized_post api_v1_tax_incomes_url, params: { tax_income: valid_attributes, estimation: { token: nil } }
          end.to change(Api::V1::TaxIncome, :count).by(1)
        end

        it 'creates a new Api::V1::TaxIncome to same user' do
          expect do
            authorized_post api_v1_tax_incomes_url, params: { tax_income: valid_attributes.merge({ client_id: evil.id }), estimation: { token: nil } }
          end.to change(Api::V1::TaxIncome, :count).by(1)
          expect(Api::V1::TaxIncome.last!.client_id).to match(user.id)
        end
      end
    end

    describe 'PUT /update authenticated' do
      context 'with valid parameters' do
        it 'updates the requested api_v1_tax_income' do
          tax_income = Api::V1::TaxIncome.create! valid_attributes
          authorized_put api_v1_tax_income_url(tax_income), params: { tax_income: { observations: 'nothing to tell' } }
          tax_income.reload
          expect(tax_income.observations).to match('nothing to tell')
        end
      end
    end
  end

  context 'when not logged in' do
    describe 'renders a error/unauthorized response' do
      it 'GET /index' do
        Api::V1::TaxIncome.create! valid_attributes
        get api_v1_tax_incomes_url
        expect(response.body).to match('not authorized')
        expect(response).to have_http_status(:unauthorized)
      end
    end

    it 'GET /show' do
      tax_income = Api::V1::TaxIncome.create! valid_attributes
      get api_v1_tax_income_url(tax_income)
      expect(response.body).to match('not authorized')
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
