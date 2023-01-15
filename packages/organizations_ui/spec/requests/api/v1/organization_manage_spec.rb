require 'rails_helper'

RSpec.describe 'Organization' do
  let(:user) { create(:user) }
  let(:lawyer) { create(:lawyer) }
  let(:lawyer_not_owner) { create(:lawyer) }
  let(:organization) { create(:organization, owner_id: lawyer.id) }
  let(:organization_two) { create(:organization) }
  let(:lawyer_profile) { create(:lawyer_profile, user_id: lawyer_not_owner.id, organization_id: organization.id) }

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

  describe 'POST /organizations/:id/manage/accept/:lawyer_profile_id' do
    context 'when logged in lawyer and owner account and lawyer pending' do
      before do
        sign_in(lawyer)
      end

      it 'renders a successful response' do
        authorized_post accept_api_v1_organization_manage_index_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to be_successful
      end

      it 'accepts lawyer' do
        authorized_post accept_api_v1_organization_manage_index_url(organization.id, lawyer_profile.id), as: :json
        expect(lawyer_profile.reload.org_status).to eq('accepted')
      end
    end

    context 'when logged in lawyer and owner account and lawyer not asked' do
      before do
        sign_in(lawyer)
        lawyer_profile.update!(organization_id: organization_two.id)
      end

      it 'renders forbidden' do
        authorized_post accept_api_v1_organization_manage_index_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when logged in lawyer and not owner account' do
      before do
        sign_in(lawyer_not_owner)
      end

      it 'renders forbidden' do
        authorized_post accept_api_v1_organization_manage_index_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user account' do
      before do
        sign_in(user)
      end

      it 'renders forbidden' do
        authorized_post accept_api_v1_organization_manage_index_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST /organizations/:id/manage/reject/:lawyer_profile_id' do
    context 'when logged in lawyer and owner account and lawyer pending' do
      before do
        sign_in(lawyer)
      end

      it 'renders a successful response' do
        authorized_post reject_api_v1_organization_manage_index_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to be_successful
      end

      it 'rejects lawyer' do
        authorized_post reject_api_v1_organization_manage_index_url(organization.id, lawyer_profile.id), as: :json
        expect(lawyer_profile.reload.org_status).to eq('rejected')
      end
    end

    context 'when logged in lawyer and owner account and lawyer not asked' do
      before do
        sign_in(lawyer)
        lawyer_profile.update!(organization_id: organization_two.id)
      end

      it 'renders forbidden' do
        authorized_post reject_api_v1_organization_manage_index_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when logged in lawyer and not owner account' do
      before do
        sign_in(lawyer_not_owner)
      end

      it 'renders forbidden' do
        authorized_post reject_api_v1_organization_manage_index_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user account' do
      before do
        sign_in(user)
      end

      it 'renders forbidden' do
        authorized_post reject_api_v1_organization_manage_index_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
