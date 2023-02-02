require 'rails_helper'

describe Api::V1::Services::LawProfUpdateService, type: :service do
  subject(:service) { described_class.new }

  let(:user) { create(:user) }
  let(:lawyer) { create(:lawyer) }
  let(:lawyer_profile) { create(:lawyer_profile, user: lawyer) }
  let(:organization) { create(:organization) }

  describe '#call' do
    context 'with valid params and lawyer account' do
      let(:params) { { organization_id: organization.id, user_id: lawyer.id } }

      it 'updates a lawyer profile' do
        expect { service.call(lawyer, lawyer_profile.id, params) }
          .not_to(change { lawyer_profile.reload.organization_id })
      end
    end

    # rubocop:disable Lint/AmbiguousBlockAssociation
    context 'with valid params and user account' do
      let(:params) { { organization_id: organization.id, user_id: user.id } }

      it 'does not update a lawyer profile' do
        expect do
          expect { service.call(user, lawyer_profile.id, params) }
            .to raise_error(Pundit::NotAuthorizedError)
        end
          .not_to change { lawyer_profile.reload.organization_id }
      end

      it 'raises an error' do
        expect { service.call(user, lawyer_profile.id, params) }
          .to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'with invalid params' do
      let(:params) { { organization_id: -1, user_id: lawyer.id } }

      it 'does not update a lawyer profile' do
        expect do
          service.call(lawyer, lawyer_profile.id, params.merge({ user_id: nil }))
        end
          .not_to change { lawyer_profile.reload.organization_id }
      end

      it 'does raise an error' do
        expect { service.call(lawyer, lawyer_profile.id, params.merge({ user_id: nil }), raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end
    # rubocop:enable Lint/AmbiguousBlockAssociation
  end
end
