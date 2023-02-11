require 'rails_helper'

describe Api::V1::Services::OrgCreateService, type: :service do
  subject(:service) { described_class.new }

  let(:org_manage) { create(:org_manage) }
  let(:valid_attributes) { attributes_for(:organization) }

  describe '#call' do
    context 'with valid attributes' do
      it 'does persist organization' do
        user = service.call(org_manage, valid_attributes.merge!(owner_id: org_manage.id))
        expect(user.persisted?).to be true
      end

      it 'does not raise error' do
        expect { service.call(org_manage, valid_attributes.merge!(owner_id: org_manage.id)) }
          .not_to raise_error
      end
    end

    context 'with invalid attributes' do
      it 'does not persist organization' do
        user = service.call(org_manage, valid_attributes.merge!(owner_id: org_manage.id, name: nil))
        expect(user.persisted?).to be false
      end

      it 'does raise error' do
        expect { service.call(org_manage, valid_attributes.merge!(owner_id: org_manage.id, name: nil), raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not raise error' do
        expect { service.call(org_manage, valid_attributes.merge!(owner_id: org_manage.id, name: nil)) }
          .not_to raise_error
      end
    end
  end
end
