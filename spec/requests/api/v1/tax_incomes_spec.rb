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

RSpec.describe "/api/v1/tax_incomes" do
 
  let(:user) {create(:user)}
  
  let(:valid_attributes) do
    {observations: "this is a test", user_id: user.id}
  end

  let(:invalid_attributes) do
    {observations: 3, id: 4, user_id: 3}
  end

  describe "GET /index authenticated" do
    before do
      sign_in(user)
    end

    it "renders a successful response" do
      Api::V1::TaxIncome.create! valid_attributes
      get api_v1_tax_incomes_url
      expect(response).to be_successful
    end
  end

  describe "GET /show authenticated" do
    before do
      sign_in(user)
    end

    it "renders a successful response" do
      tax_income = Api::V1::TaxIncome.create! valid_attributes
      get api_v1_tax_income_url(tax_income)
      expect(response).to be_successful
    end
  end

  describe "POST /create authenticated" do
    before do
      sign_in(user)
    end

    context "with valid parameters" do
      it "creates a new Api::V1::TaxIncome" do
        expect do
          post api_v1_tax_incomes_url, params: { tax_income: valid_attributes, estimation: {token: nil} }
        end.to change(Api::V1::TaxIncome, :count).by(1)
      end

    end
  end

  describe "PATCH /update authenticated" do
    before do
      sign_in(user)
    end

    context "with valid parameters" do
      let(:new_attributes) do
        {observations: "nothing to tell"}
      end

      it "updates the requested api_v1_tax_income" do
        tax_income = Api::V1::TaxIncome.create! valid_attributes
        patch api_v1_tax_income_url(tax_income), params: { tax_income: new_attributes }
        tax_income.reload
        expect(tax_income.observations).to match(new_attributes[:observations])
      end
    end
  end

  context "when not logged in" do
    describe "renders a error/unauthorized response" do
      it "GET /index" do
        Api::V1::TaxIncome.create! valid_attributes
        get api_v1_tax_incomes_url
        expect(response.body).to match("sign in or sign up")
        expect(response).to have_http_status(:unauthorized) 
      end
    end

    it "GET /show" do
      tax_income = Api::V1::TaxIncome.create! valid_attributes
      get api_v1_tax_income_url(tax_income)
      expect(response.body).to match("sign in or sign up")
      expect(response).to have_http_status(:unauthorized) 
    end
  end
end
