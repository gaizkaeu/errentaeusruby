require 'rails_helper'

describe Api::V1::Services::OrgCreateCheckoutSession, type: :service do
  subject(:service) { described_class.new }

  let(:user) { create(:user, account_type: 'org_manage') }
  let(:organization) { create(:organization, owner_id: user.id, status: 'not_subscribed', subscription_id: nil) }

  describe '#call' do
    let(:params) do
      {
        id: organization.id,
        return_url: '/success',
        price_id: 'price_1MWLPLGrlIhNYf6eiDdiG8XZ'
      }
    end

    it 'calls stripe api' do
      allow(Stripe::Checkout::Session).to receive(:create).and_return(true)

      service.call(user, params)

      expect(Stripe::Checkout::Session).to have_received(:create)
    end

    it 'returns a checkout session' do
      expect(service.call(user, params).url).to be_a(String)
    end

    context 'with raise_error' do
      let(:user2) { create(:user) }

      it 'raises an error if the organization is not found' do
        params[:id] = 'not_found'

        expect { service.call(user, params, raise_error: true) }
          .to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'raises error if the user is not authorized' do
        expect { service.call(user2, params, raise_error: true) }
          .to raise_error(Pundit::NotAuthorizedError)
      end

      it 'raises an error if already subscribed' do
        organization.update!(subscription_id: 'sub_123')

        expect { service.call(user, params, raise_error: true) }
          .to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'without raise_error' do
      let(:user2) { create(:user) }

      it 'does raise error if the user is not authorized' do
        expect { service.call(user2, params) }
          .to raise_error(Pundit::NotAuthorizedError)
      end

      it 'does not raise an error if already subscribed' do
        organization.update!(subscription_id: 'sub_123')

        expect { service.call(user, params) }
          .not_to raise_error
        expect(service.call(user, params)).to be_nil
      end
    end
  end
end
