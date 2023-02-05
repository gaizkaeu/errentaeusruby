require 'rails_helper'

RSpec.describe OrgTrackNewTransactionJob do
  let!(:org) { create(:organization) }
  let!(:trn) { create(:transaction, metadata: { organization_id: org.id }) }

  let(:params) do
    {
      organization_id: org.id,
      trn_id: trn.id
    }
  end

  describe '#perform' do
    context 'with already existing record and successful payment' do
      let!(:org_stat) { create(:organization_stat, organization_id: org.id, date: Time.zone.today, balance_today: 200) }
      let!(:org_stat2) { create(:organization_stat, organization_id: org.id, date: Time.zone.today + 1, balance_today: 200) }

      it 'updates the record' do
        expect { described_class.perform_now(params) }
          .to change { org_stat.reload.balance_today }
          .from(200)
          .to(300)
      end

      it 'updates the correct record' do
        expect { described_class.perform_now(params) }
          .to change { org_stat.reload.balance_today }
          .from(200)
          .to(300)

        expect { described_class.perform_now(params) }
          .not_to(change { org_stat2.reload.balance_today })
      end
    end

    context 'with already existing record and requires_capture payment' do
      let!(:org_stat) { create(:organization_stat, organization_id: org.id, date: Time.zone.today, balance_today: 200, balance_capturable_today: 0) }

      it 'updates the record' do
        trn = create(:transaction, metadata: { organization_id: org.id }, status: 'requires_capture', amount_capturable: 100)
        expect { described_class.perform_now(params.merge!(trn_id: trn.id)) }
          .to change { org_stat.reload.balance_capturable_today }
          .from(0)
          .to(100)
      end
    end

    context 'with no existing record' do
      it 'creates a new record' do
        expect { described_class.perform_now(params) }
          .to change(Api::V1::Repositories::OrganizationStatRepository, :count)
          .by(1)
      end

      it 'creates a new record with correct attributes' do
        described_class.perform_now(params)

        expect(Api::V1::Repositories::OrganizationStatRepository.last).to have_attributes(
          organization_id: org.id,
          date: Time.zone.today,
          balance_today: 100,
          balance_capturable_today: 0
        )
      end
    end
  end
end
