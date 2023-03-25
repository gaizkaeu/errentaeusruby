require 'rails_helper'

describe Api::V1::Services::OrgSubscriptionUpdatedService, type: :service do
  subject(:service) { described_class.new }

  let(:organization) { create(:organization) }

  describe '#call' do
    let(:subscription_object) do
      {
        id: 'sub_123',
        customer: 'cus_123',
        metadata: {
          id: organization.id
        },
        items: {
          data: [
            {
              id: 'si_123',
              plan: {
                id: 'plan_123',
                product: 'prod_123',
                metadata: {
                  subscription_type: 'featured_city'
                }
              },
              price: {
                id: 'price_123',
                product: 'prod_123'
              }
            }
          ]
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
        .from(nil).to('sub_123')
    end

    it 'updates the organization status' do
      expect { service.call(event) }
        .to change { organization.reload.status }
        .from('not_subscribed').to('featured_city')
    end

    it 'raises an error if the organization is not found' do
      subscription_object[:metadata][:id] = 'not_found'

      expect { service.call(event) }
        .to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'raises an error if the subscription type is not found' do
      subscription_object[:items][:data].first[:plan][:metadata][:subscription_type] = 'not_found'

      expect { service.call(event) }
        .to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
