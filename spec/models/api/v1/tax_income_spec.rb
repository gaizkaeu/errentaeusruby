require 'rails_helper'

RSpec.describe Api::V1::TaxIncome do
  let(:user) {create(:user)}
  
  let(:valid_attributes) do
    {observations: "this is a test", user_id: user.id}
  end

  let(:invalid_attributes) do
    {observations: "this is a test", user_id: -1}
  end
 
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  context "with valid attributes" do
    describe "user valid" do
      it "creates tax income" do
        tax_income = described_class.new valid_attributes
        expect(tax_income).to be_valid
      end
    end
  end

  context "with invalid attributes" do
    describe "user invalid" do
      it "creates tax income" do
        tax_income = described_class.new invalid_attributes
        expect(tax_income).not_to be_valid
      end
    end
  end
end

