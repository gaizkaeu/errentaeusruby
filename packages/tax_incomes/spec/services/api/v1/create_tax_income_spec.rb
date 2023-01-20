require 'rails_helper'

describe Api::V1::Services::CreateTaxService, type: :service do
  subject(:service) { described_class.new }

  let(:user_record) { create(:user) }
  let(:user) { Api::V1::User.new(user_record.attributes.symbolize_keys!) }
  let(:lawyer_profile) { create(:lawyer_profile) }
  let(:organization) { create(:organization) }

  let(:params) { { client_id: user.id, organization_id: organization.id } }
  let(:invalid) { { client_id: lawyer_profile.id, year: 'asd', lawyer_id: lawyer_profile.id, organization_id: organization.id } }
  let(:unauthorized) { { client_id: user.id, year: 'asd', lawyer_id: user.id } }

  describe '#call' do
    context 'with valid params' do
      it 'creates a tax income' do
        expect { service.call(user, params) }
          .to change(Api::V1::Repositories::TaxIncomeRepository, :count)
          .by(1)
      end

      it 'publishes a tax income created event' do
        expect { service.call(user, params) }
          .to have_enqueued_job(TaxIncomeCreatedJob)
      end
    end

    context 'with unauthorized action' do
      it 'raises an error' do
        expect { service.call(lawyer_profile.user, unauthorized) }
          .to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'with invalid params' do
      it 'does not create a tax income' do
        expect { service.call(lawyer_profile.user, invalid) }
          .not_to change(Api::V1::Repositories::TaxIncomeRepository, :count)
      end

      it 'does raise an error' do
        expect { service.call(lawyer_profile.user, invalid, raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not publish a tax income created event' do
        expect { service.call(lawyer_profile.user, invalid) }
          .not_to have_enqueued_job(TaxIncomeCreatedJob)
      end
    end
  end
end
