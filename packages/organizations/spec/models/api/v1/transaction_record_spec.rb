require 'rails_helper'

RSpec.describe Api::V1::TransactionRecord do
  describe 'associations' do
    it { is_expected.to belong_to(:user).class_name('Api::V1::UserRecord') }
    it { is_expected.to belong_to(:organization).class_name('Api::V1::OrganizationRecord') }
    it { is_expected.to have_readonly_attribute(:user_id) }
    it { is_expected.to have_readonly_attribute(:organization_id) }
    it { is_expected.to have_readonly_attribute(:payment_intent_id) }
    it { is_expected.to have_readonly_attribute(:amount) }
    it { is_expected.to have_readonly_attribute(:metadata) }
  end

  describe 'scopes' do
    describe 'filter_by_amount_greater_than' do
      let(:transaction) { create(:transaction, amount: 100) }
      let(:transaction_two) { create(:transaction, amount: 200) }

      it 'returns transactions by amount greater than' do
        expect(described_class.filter_by_amount_greater_than(100)).to eq([transaction_two])
      end
    end

    describe 'filter_by_amount_less_than' do
      let(:transaction) { create(:transaction, amount: 100) }
      let(:transaction_two) { create(:transaction, amount: 200) }

      it 'returns transactions by amount less than' do
        expect(described_class.filter_by_amount_less_than(200)).to eq([transaction])
      end
    end

    describe 'filter_by_status' do
      let(:transaction) { create(:transaction, status: 'succeeded') }
      let(:transaction_two) { create(:transaction, status: 'requires_capture') }

      it 'returns transactions by status' do
        expect(described_class.filter_by_status('succeeded')).to eq([transaction])
      end
    end

    describe 'filter_by_user_id' do
      let(:user) { create(:user) }
      let(:user_two) { create(:user) }
      let(:transaction) { create(:transaction, user:) }
      let(:transaction_two) { create(:transaction, user: user_two) }

      it 'returns transactions by user id' do
        expect(described_class.filter_by_user_id(user.id)).to eq([transaction])
      end
    end

    describe 'filter_by_organization_id' do
      let(:organization) { create(:organization) }
      let(:organization_two) { create(:organization) }
      let(:transaction) { create(:transaction, organization:) }
      let(:transaction_two) { create(:transaction, organization: organization_two) }

      it 'returns transactions by organization id' do
        expect(described_class.filter_by_organization_id(organization.id)).to eq([transaction])
      end
    end

    describe 'filter_by_payment_intent_id' do
      let(:transaction) { create(:transaction, payment_intent_id: 'pi_1') }
      let(:transaction_two) { create(:transaction, payment_intent_id: 'pi_2') }

      it 'returns transactions by payment intent id' do
        expect(described_class.filter_by_payment_intent_id('pi_1')).to eq([transaction])
      end
    end
  end
end
