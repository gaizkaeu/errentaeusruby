require 'rails_helper'

describe Api::V1::Services::OrgSubscriptionDeleted, type: :service do
  subject(:service) { described_class.new }

  let(:organization) { create(:organization, subscription_id: 'asd', status: 'featured_city') }

  describe '#call' do
    let(:subscription_object) do
      {
        id: 'sub_123',
        customer: 'cus_123',
        metadata: {
          id: organization.id
        }
      }
    end

    let(:event) do
      {
        data: {
          object: subscription_object
        }
      }
    end

    it 'updates the organization subscription' do
      expect { service.call(event) }
        .to change { organization.reload.subscription_id }
        .from('asd').to(nil)
    end

    it 'updates the organization status' do
      expect { service.call(event) }
        .to change { organization.reload.status }
        .to('not_subscribed')
    end

    it 'raises an error if the organization is not found' do
      subscription_object[:metadata][:id] = 'not_found'

      expect { service.call(event) }
        .to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
