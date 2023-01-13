require 'rails_helper'

describe Api::V1::Services::CreateOrganizationService, type: :service do
  subject(:service) { described_class.new }

  let(:lawyer) { create(:lawyer) }
  let(:lawyer_user) { Api::V1::Repositories::UserRepository.find(lawyer.id) }
  let(:valid_attributes) { attributes_for(:organization) }

  describe '#call' do
    context 'with valid attributes' do
      it 'does persist organization' do
        user = service.call(lawyer_user, valid_attributes.merge!(owner_id: lawyer_user.id))
        expect(user.persisted?).to be true
      end

      it 'does not raise error' do
        expect { service.call(lawyer_user, valid_attributes.merge!(owner_id: lawyer_user.id)) }
          .not_to raise_error
      end
    end

    context 'with invalid attributes' do
      it 'does not persist organization' do
        user = service.call(lawyer_user, valid_attributes.merge!(owner_id: lawyer_user.id, name: nil))
        expect(user.persisted?).to be false
      end

      it 'does raise error' do
        expect { service.call(lawyer_user, valid_attributes.merge!(owner_id: lawyer_user.id, name: nil), raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not raise error' do
        expect { service.call(lawyer_user, valid_attributes.merge!(owner_id: lawyer_user.id, name: nil)) }
          .not_to raise_error
      end
    end
  end
end
