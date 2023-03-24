require 'rails_helper'

describe Api::V1::Services::LawProfCreateService, type: :service do
  subject(:service) { described_class.new }

  let(:user) { create(:user) }
  let(:lawyer) { create(:lawyer) }
  let(:organization) { create(:organization) }

  describe '#call' do
    context 'with valid params and lawyer account' do
      let(:params) { { organization_id: organization.id, user_id: lawyer.id } }

      it 'creates a lawyer profile' do
        expect { service.call(lawyer, params) }
          .to change(Api::V1::Repositories::LawyerProfileRepository, :count)
          .by(1)
      end
    end

    context 'with valid params and user account' do
      let(:params) { { organization_id: organization.id, user_id: user.id } }

      it 'does not create a lawyer profile' do
        expect do
          expect { service.call(user, params) }
            .to raise_error(Pundit::NotAuthorizedError)
        end
          .not_to change(Api::V1::Repositories::LawyerProfileRepository, :count)
      end

      it 'raises an error' do
        expect { service.call(user, params) }
          .to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'with invalid params' do
      let(:params) { { organization_id: -1, user_id: lawyer.id } }

      it 'does not create a lawyer profile' do
        expect { service.call(lawyer, params.merge({ user_id: nil })) }
          .not_to change(Api::V1::Repositories::LawyerProfileRepository, :count)
      end

      it 'does raise an error' do
        expect { service.call(lawyer, params.merge({ user_id: nil }), raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
