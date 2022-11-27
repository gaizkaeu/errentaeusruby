require 'rails_helper'

RSpec.describe Api::V1::TaxIncome do
  let(:user) {create(:user)}
  let(:lawyer) {create(:lawyer)}
  
  let(:valid_attributes) do
    {observations: "this is a test", client_id: user.id}
  end

  let(:valid_attributes_with_lawyer) do
    {observations: "this is a test", client_id: user.id, lawyer_id: lawyer.id}
  end

  let(:invalid_attributes) do
    {observations: "this is a test", client_id: -1}
  end

  describe "state machine testing" do
    it "start with pending assignation" do
      tax = described_class.new valid_attributes
      expect(tax).to have_state(:pending_assignation)
    end

    it "transitions to waiting for meeting with lawyer" do
      tax = described_class.create! valid_attributes_with_lawyer
      expect(tax).to have_state(:waiting_for_meeting_creation)
      tax.reload
      expect(tax).to be_lawyer_assigned
    end

    it "transitions to waiting for meeting after assign lawyer" do
      tax = described_class.new valid_attributes
      expect(tax).to have_state(:pending_assignation)
      tax.save!
      expect(tax).to have_state(:waiting_for_meeting_creation)
    end

    it "does not transition without lawyer" do
      tax = described_class.new valid_attributes
      expect(tax).not_to allow_event :assigned_lawyer
    end

    it "transitions to waiting meeting without meeting creation" do
      tax = described_class.create! valid_attributes
      expect(tax).not_to allow_transition_to(:waiting_for_meeting)
    end
  end
 
  describe "associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to have_one(:estimation) }
    it { is_expected.to have_one(:appointment) }
    it { is_expected.to have_many(:documents) }
  end

  describe "params" do
    it {  is_expected.to accept_nested_attributes_for(:estimation) }
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

