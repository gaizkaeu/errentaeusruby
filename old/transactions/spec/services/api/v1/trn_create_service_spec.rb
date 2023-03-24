require 'rails_helper'

describe Api::V1::Services::TrnCreateService, type: :service do
  subject(:service) { described_class.new }

  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  let(:valid_attributes) { attributes_for(:transaction, organization_id: organization.id, user_id: user.id) }

  describe '#call' do
    context 'with valid attributes' do
      it 'does create transaction' do
        expect { service.call(valid_attributes, raise_error: true) }
          .to change(Api::V1::Repositories::TransactionRepository, :count)
          .by(1)
      end

      it 'does return transaction' do
        expect(service.call(valid_attributes)).to be_an_instance_of(Api::V1::Transaction)
      end

      it 'does not raise error' do
        expect { service.call(valid_attributes) }
          .not_to raise_error
      end

      it 'does enqueue transaction created job' do
        expect { service.call(valid_attributes) }
          .to have_enqueued_job(OrgTrackNewTransactionJob)
      end
    end

    context 'with invalid attributes' do
      it 'does not create transaction' do
        expect { service.call(valid_attributes.merge!({ amount: nil })) }
          .not_to change(Api::V1::Repositories::TransactionRepository, :count)
      end

      it 'does raise error' do
        expect { service.call(valid_attributes.merge!(amount: nil), raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not enqueue transaction created job' do
        expect { service.call(valid_attributes.merge!(amount: nil)) }
          .not_to have_enqueued_job(OrgTrackNewTransactionJob)
      end
    end
  end
end
