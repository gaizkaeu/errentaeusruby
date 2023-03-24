require 'rails_helper'

describe Api::V1::Services::OrgCreateService, type: :service do
  subject(:service) { described_class.new }

  let(:org_manage) { create(:org_manage) }
  let(:org_manage_user) { Api::V1::Repositories::UserRepository.find(org_manage.id) }
  let(:valid_attributes) { attributes_for(:organization) }

  describe '#call' do
    context 'with valid attributes' do
      it 'does persist organization' do
        user = service.call(org_manage_user, valid_attributes.merge!(owner_id: org_manage_user.id))
        expect(user.persisted?).to be true
      end

      it 'does not raise error' do
        expect { service.call(org_manage_user, valid_attributes.merge!(owner_id: org_manage_user.id)) }
          .not_to raise_error
      end
    end

    context 'with invalid attributes' do
      it 'does not persist organization' do
        user = service.call(org_manage_user, valid_attributes.merge!(owner_id: org_manage_user.id, name: nil))
        expect(user.persisted?).to be false
      end

      it 'does raise error' do
        expect { service.call(org_manage_user, valid_attributes.merge!(owner_id: org_manage_user.id, name: nil), raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not raise error' do
        expect { service.call(org_manage_user, valid_attributes.merge!(owner_id: org_manage_user.id, name: nil)) }
          .not_to raise_error
      end
    end
  end
end
