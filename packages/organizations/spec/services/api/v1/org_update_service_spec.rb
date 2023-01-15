require 'rails_helper'

describe Api::V1::Services::OrgUpdateService, type: :service do
  subject(:service) { described_class.new }

  let(:lawyer) { create(:lawyer) }
  let(:lawyer_user) { Api::V1::Repositories::UserRepository.find(lawyer.id) }
  let(:organization) { create(:organization, owner_id: lawyer.id) }
  let(:valid_attributes) { attributes_for(:organization) }

  # rubocop:disable Lint/AmbiguousBlockAssociation
  describe '#call' do
    context 'with valid attributes and authorized account' do
      it 'does update organization' do
        expect { service.call(lawyer_user, organization.id, { name: 'asda' }, raise_error: true) }
          .to change { organization.reload.name }
          .from(organization.name).to('asda')
      end

      it 'does return organization' do
        expect(service.call(lawyer_user, organization.id, valid_attributes)).to eq(organization)
      end

      it 'does not raise error' do
        expect { service.call(lawyer_user, organization.id, valid_attributes) }
          .not_to raise_error
      end
    end

    context 'with valid attributes and unauthorized account' do
      context 'with not owner account' do
        it 'does not update organization' do
          expect do
            expect do
              service.call(create(:lawyer), organization.id, valid_attributes)
            end.to raise_error(Pundit::NotAuthorizedError)
          end.not_to change { organization.reload.name }
        end

        it 'does raise error' do
          expect { service.call(create(:lawyer), organization.id, valid_attributes) }
            .to raise_error(Pundit::NotAuthorizedError)
        end
      end

      context 'with not lawyer account' do
        it 'does not update organization' do
          expect do
            expect do
              service.call(create(:user), organization.id, valid_attributes)
            end.to raise_error(Pundit::NotAuthorizedError)
          end.not_to change { organization.reload.name }
        end

        it 'does raise error' do
          expect { service.call(create(:user), organization.id, valid_attributes) }
            .to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end

    context 'with invalid attributes' do
      it 'does not update organization' do
        expect do
          expect do
            service.call(lawyer_user, organization.id, { name: nil }, raise_error: true)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end.not_to change { organization.reload.name }
      end

      it 'does raise error' do
        expect { service.call(lawyer_user, organization.id, { name: nil }, raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
  # rubocop:enable Lint/AmbiguousBlockAssociation
end
