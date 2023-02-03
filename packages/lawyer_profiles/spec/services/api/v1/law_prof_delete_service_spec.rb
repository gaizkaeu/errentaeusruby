require 'rails_helper'

describe Api::V1::Services::LawProfDeleteService, type: :service do
  subject(:service) { described_class.new }

  let(:user) { create(:user) }
  let(:organization) { create(:organization, owner_id: user.id) }

  # rubocop:disable Lint/AmbiguousBlockAssociation
  describe '#call' do
    context 'with asked join user and authorized account' do
      let(:lawyer_profile) { create(:lawyer_profile, user:, organization:, org_status: :pending) }

      it 'does reject user' do
        expect { service.call(organization.owner, lawyer_profile.id) }
          .not_to change { lawyer_profile.reload.org_status }
      end

      it 'does return user profile' do
        expect(service.call(organization.owner, lawyer_profile.id)).to eq(lawyer_profile)
      end

      it 'does not raise error' do
        expect { service.call(organization.owner, lawyer_profile.id) }
          .not_to raise_error
      end
    end

    context 'with asked join user and unauthorized account' do
      let(:lawyer_profile) { create(:lawyer_profile, user:, organization:, org_status: :pending) }

      context 'with not owner account' do
        it 'does not reject user' do
          expect do
            expect do
              service.call(create(:user), lawyer_profile.id)
            end.to raise_error(Pundit::NotAuthorizedError)
          end.not_to change { lawyer_profile.reload.org_status }
        end

        it 'does raise error' do
          expect { service.call(create(:user), lawyer_profile.id) }
            .to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end
  end

  # rubocop:enable Lint/AmbiguousBlockAssociation
end
