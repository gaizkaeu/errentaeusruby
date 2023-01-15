require 'rails_helper'

RSpec.describe 'Organization' do
  let(:user) { create(:user) }
  let(:lawyer) { create(:lawyer) }
  let(:lawyer_not_owner) { create(:lawyer) }
  let(:organization) { create(:organization, owner_id: lawyer.id) }
  let(:lawyer_profile) { create(:lawyer_profile, user_id: lawyer.id) }

  describe 'GET /organizations/:id/manage/lawyers' do
    context 'when logged in lawyer and owner account' do
      before do
        sign_in(lawyer)
      end

      it 'renders a successful response' do
        authorized_get lawyers_api_v1_organization_manage_index_url(organization.id), as: :json
        expect(response).to be_successful
      end
    end

    context 'when logged in lawyer and not owner account' do
      before do
        sign_in(lawyer_not_owner)
      end

      it 'renders forbidden' do
        authorized_get lawyers_api_v1_organization_manage_index_url(organization.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user account' do
      before do
        sign_in(user)
      end

      it 'renders forbidden' do
        authorized_get lawyers_api_v1_organization_manage_index_url(organization.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
