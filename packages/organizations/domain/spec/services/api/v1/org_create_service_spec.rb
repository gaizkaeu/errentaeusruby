require 'rails_helper'

describe Api::V1::Services::OrgCreateService, type: :service do
  subject(:service) { described_class.new }

  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:organization) }

  describe '#call' do
    context 'with valid attributes' do
      it 'does persist organization' do
        org = service.call(user, valid_attributes)
        expect(org.persisted?).to be true
      end

      it 'does not raise error' do
        expect { service.call(user, valid_attributes) }
          .not_to raise_error
      end

      describe 'organization membership' do
        context 'with successful save' do
          let(:org) { service.call(user, valid_attributes) }

          it 'does persist membership' do
            expect(org.memberships.count).to eq 1
          end

          it 'does persist membership with admin role' do
            expect(org.memberships.first.role).to eq 'admin'
          end

          it 'does persist membership with current user' do
            expect(org.memberships.first.user).to eq user
          end
        end

        context 'with failed save for membership' do
          before do
            user.id = -1
          end

          let(:org) { service.call(user, valid_attributes) }

          it 'does not persist membership' do
            expect(org.memberships.count).to eq 0
          end

          it 'does not persist organization' do
            expect(org.persisted?).to be false
          end

          it 'does show error on organization' do
            expect(org.errors.messages).to include({ user: ['must exist'] })
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'does not persist organization' do
        org = service.call(user, valid_attributes.merge!(name: nil))
        expect(org.persisted?).to be false
      end

      it 'does raise error' do
        expect { service.call(user, valid_attributes.merge!(name: nil), raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
