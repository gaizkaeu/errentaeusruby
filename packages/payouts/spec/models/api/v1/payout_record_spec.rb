require 'rails_helper'

RSpec.describe Api::V1::PayoutRecord do
  describe 'associations' do
    it { is_expected.to belong_to(:organization).class_name('Api::V1::OrganizationRecord') }
    it { is_expected.to have_readonly_attribute(:organization_id) }
    it { is_expected.to have_readonly_attribute(:amount) }
  end

  describe 'scopes' do
    describe 'filter_by_amount_greater_than' do
      let(:payout) { create(:payout, amount: 100) }
      let(:payout_two) { create(:payout, amount: 200) }

      it 'returns payouts by amount greater than' do
        expect(described_class.filter_by_amount_greater_than(100)).to eq([payout_two])
      end
    end

    describe 'filter_by_amount_less_than' do
      let(:payout) { create(:payout, amount: 100) }
      let(:payout_two) { create(:payout, amount: 200) }

      it 'returns payouts by amount less than' do
        expect(described_class.filter_by_amount_less_than(200)).to eq([payout])
      end
    end

    describe 'filter_by_status' do
      let(:payout) { create(:payout, status: 'pending') }
      let(:payout_two) { create(:payout, status: 'paid') }

      it 'returns payouts by status' do
        expect(described_class.filter_by_status('pending')).to eq([payout])
      end
    end

    describe 'filter_by_organization_id' do
      let(:organization) { create(:organization) }
      let(:organization_two) { create(:organization) }
      let(:payout) { create(:payout, organization:) }
      let(:payout_two) { create(:payout, organization: organization_two) }

      it 'returns payouts by organization id' do
        expect(described_class.filter_by_organization_id(organization.id)).to eq([payout])
      end
    end
  end
end
