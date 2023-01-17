require 'rails_helper'

describe Api::V1::Services::LawProfRejectService, type: :service do
  subject(:service) { described_class.new }

  let(:lawyer) { create(:lawyer) }
  let(:organization) { create(:organization) }

  # rubocop:disable Lint/AmbiguousBlockAssociation
  describe '#call' do
    context 'with asked join lawyer and authorized account' do
      let(:lawyer_profile) { create(:lawyer_profile, user: lawyer, organization:, org_status: :pending) }

      it 'does reject lawyer' do
        expect { service.call(organization.owner, organization.id, lawyer_profile.id) }
          .to change { lawyer_profile.reload.org_status }
          .from('pending').to('rejected')
      end

      it 'does return lawyer profile' do
        expect(service.call(organization.owner, organization.id, lawyer_profile.id)).to eq(lawyer_profile)
      end

      it 'does not raise error' do
        expect { service.call(organization.owner, organization.id, lawyer_profile.id) }
          .not_to raise_error
      end
    end

    context 'with asked join lawyer and unauthorized account' do
      let(:lawyer_profile) { create(:lawyer_profile, user: lawyer, organization:, org_status: :pending) }

      context 'with not owner account' do
        it 'does not reject lawyer' do
          expect do
            expect do
              service.call(create(:lawyer), organization.id, lawyer_profile.id)
            end.to raise_error(Pundit::NotAuthorizedError)
          end.not_to change { lawyer_profile.reload.org_status }
        end

        it 'does raise error' do
          expect { service.call(create(:lawyer), organization.id, lawyer_profile.id) }
            .to raise_error(Pundit::NotAuthorizedError)
        end
      end

      context 'with not lawyer account' do
        it 'does not reject lawyer' do
          expect do
            expect do
              service.call(create(:user), organization.id, lawyer_profile.id)
            end.to raise_error(Pundit::NotAuthorizedError)
          end.not_to change { lawyer_profile.reload.org_status }
        end

        it 'does raise error' do
          expect { service.call(create(:user), organization.id, lawyer_profile.id) }
            .to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end
  end

  # rubocop:enable Lint/AmbiguousBlockAssociation
end
