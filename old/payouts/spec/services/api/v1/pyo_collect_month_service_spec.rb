require 'rails_helper'

describe Api::V1::Services::PyoCollectMonthService, type: :service do
  subject(:service) { described_class.new }

  let(:organization) { create(:organization) }

  describe '#call' do
    context 'with 10 transactions' do
      let(:transactions) { create_list(:transaction, 10, organization:) }

      it 'does create payout object' do
        expect { service.call(organization.id, transactions.first.created_at) }
          .to change(Api::V1::Repositories::PayoutRepository, :count)
          .by(1)
      end

      it 'does create payout object with correct params' do
        service.call(organization.id, transactions.first.created_at)
        payout = Api::V1::Repositories::PayoutRepository.last
        expect(payout.amount).to eq(1000)
        expect(payout.organization_id).to eq(organization.id)
        expect(payout.metadata['transaction_ids']).to eq(transactions.map(&:id))
      end

      it 'does calculate amount based on status' do
        transactions.first.update!(status: :refunded)
        service.call(organization.id, transactions.first.created_at)
        payout = Api::V1::Repositories::PayoutRepository.last
        expect(payout.amount).to eq(800)
      end
    end

    context 'when no transactions' do
      it 'does not create payout object' do
        expect { service.call(organization.id, Time.zone.now) }
          .not_to change(Api::V1::Repositories::PayoutRepository, :count)
      end
    end

    context 'with 10 transactions with different date' do
      let(:transactions) { create_list(:transaction, 10, organization:) }

      it 'does not create payout object' do
        expect { service.call(organization.id, transactions.first.created_at + 1.month) }
          .not_to change(Api::V1::Repositories::PayoutRepository, :count)
      end
    end

    context 'with 10 transaction and not same month' do
      let(:transactions) { create_list(:transaction, 10, organization:) }
      let(:transaction) { create(:transaction, organization:, created_at: '2025-11-30T11:30:00.000Z') }

      it 'does create correct payouts' do
        expect { service.call(organization.id, transactions.first.created_at) }
          .to change(Api::V1::Repositories::PayoutRepository, :count)
          .by(1)
        expect { service.call(organization.id, transaction.created_at) }
          .to change(Api::V1::Repositories::PayoutRepository, :count)
          .by(1)

        payout = Api::V1::Repositories::PayoutRepository.last
        expect(payout.amount).to eq(100)
        expect(payout.organization_id).to eq(organization.id)
        expect(payout.metadata['transaction_ids']).to eq([transaction.id])

        payout = Api::V1::Repositories::PayoutRepository.first
        expect(payout.amount).to eq(1000)
        expect(payout.organization_id).to eq(organization.id)
        expect(payout.metadata['transaction_ids']).to eq(transactions.map(&:id))
      end
    end
  end
end
