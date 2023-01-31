require 'rails_helper'

RSpec.describe 'Organization' do
  let(:user) { create(:user) }
  let(:lawyer) { create(:lawyer) }
  let(:lawyer_not_owner) { create(:lawyer) }
  let(:organization) { create(:organization, owner_id: lawyer.id) }
  let(:organization_two) { create(:organization) }
  let(:lawyer_profile) { create(:lawyer_profile, user_id: lawyer_not_owner.id, organization_id: organization.id) }

  let(:valid_attributes) { attributes_for(:organization) }

  describe 'GET /organizations/:id/manage/lawyers' do
    context 'when logged in lawyer and owner account' do
      before do
        sign_in(lawyer)
      end

      it 'renders a successful response' do
        authorized_get api_v1_organization_manage_lawyer_profiles_url(organization.id), as: :json
        expect(response).to be_successful
      end
    end

    context 'when logged in lawyer and not owner account' do
      before do
        sign_in(lawyer_not_owner)
      end

      it 'renders forbidden' do
        authorized_get api_v1_organization_manage_lawyer_profiles_url(organization.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user account' do
      before do
        sign_in(user)
      end

      it 'renders forbidden' do
        authorized_get api_v1_organization_manage_lawyer_profiles_url(organization.id), as: :json
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
        authorized_post accept_api_v1_organization_manage_lawyer_profile_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to be_successful
      end

      it 'accepts lawyer' do
        authorized_post accept_api_v1_organization_manage_lawyer_profile_url(organization.id, lawyer_profile.id), as: :json
        expect(lawyer_profile.reload.org_status).to eq('accepted')
      end
    end

    context 'when logged in lawyer and owner account and lawyer not asked' do
      before do
        sign_in(lawyer)
        lawyer_profile.update!(organization_id: organization_two.id)
      end

      it 'renders forbidden' do
        authorized_post accept_api_v1_organization_manage_lawyer_profile_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when logged in lawyer and not owner account' do
      before do
        sign_in(lawyer_not_owner)
      end

      it 'renders forbidden' do
        authorized_post accept_api_v1_organization_manage_lawyer_profile_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user account' do
      before do
        sign_in(user)
      end

      it 'renders forbidden' do
        authorized_post accept_api_v1_organization_manage_lawyer_profile_url(organization.id, lawyer_profile.id), as: :json
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
        authorized_post reject_api_v1_organization_manage_lawyer_profile_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to be_successful
      end

      it 'rejects lawyer' do
        authorized_post reject_api_v1_organization_manage_lawyer_profile_url(organization.id, lawyer_profile.id), as: :json
        expect(lawyer_profile.reload.org_status).to eq('rejected')
      end
    end

    context 'when logged in lawyer and owner account and lawyer not asked' do
      before do
        sign_in(lawyer)
        lawyer_profile.update!(organization_id: organization_two.id)
      end

      it 'renders forbidden' do
        authorized_post reject_api_v1_organization_manage_lawyer_profile_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when logged in lawyer and not owner account' do
      before do
        sign_in(lawyer_not_owner)
      end

      it 'renders forbidden' do
        authorized_post reject_api_v1_organization_manage_lawyer_profile_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user account' do
      before do
        sign_in(user)
      end

      it 'renders forbidden' do
        authorized_post reject_api_v1_organization_manage_lawyer_profile_url(organization.id, lawyer_profile.id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'CREATE /organizations' do
    before do
      sign_in(lawyer)
    end

    context 'with valid attributes' do
      it 'creates a new organization' do
        expect do
          authorized_post api_v1_organization_manage_index_url, params: { organization_manage: valid_attributes }, as: :json
        end.to change(Api::V1::Repositories::OrganizationRepository, :count).by(1)
      end

      it 'renders a JSON response with the new organization' do
        authorized_post api_v1_organization_manage_index_url, params: { organization_manage: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['data']['attributes'].symbolize_keys!).to match(a_hash_including(valid_attributes.slice(:name)))
      end
    end

    context 'with invalid attributes' do
      it 'renders a JSON response with errors for the new organization' do
        authorized_post api_v1_organization_manage_index_url, params: { organization_manage: { name: '' } }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['name']).to be_present
      end

      it 'does not create a new organization' do
        expect do
          authorized_post api_v1_organization_manage_index_url, params: { organization_manage: { name: '' } }, as: :json
        end.not_to change(Api::V1::Repositories::OrganizationRepository, :count)
      end
    end
  end

  describe 'UPDATE /organizations/:id' do
    before do
      sign_in(lawyer)
    end

    # rubocop:disable RSpec/MultipleMemoizedHelpers
    context 'with valid attributes' do
      let(:new_attributes) { { name: 'New name' } }

      it 'updates the requested organization' do
        authorized_put api_v1_organization_manage_url(organization.id), params: { organization_manage: new_attributes }, as: :json
        organization.reload
        expect(response).to be_successful
        expect(organization.name).to eq('New name')
      end

      it 'renders a JSON response with the organization' do
        authorized_put api_v1_organization_manage_url(organization.id), params: { organization_manage: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data']['attributes'].symbolize_keys!).to match(a_hash_including(new_attributes.slice(:name)))
      end
    end

    context 'with invalid attributes' do
      it 'renders a JSON response with errors for the organization' do
        authorized_put api_v1_organization_manage_url(organization.id), params: { organization_manage: { name: '' } }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['name']).to be_present
      end
    end

    context 'with unauthorized lawyer' do
      let(:unauthorized_lawyer) { create(:lawyer) }

      before do
        sign_in(unauthorized_lawyer)
      end

      it 'renders unauthorized response' do
        authorized_put api_v1_organization_manage_url(organization.id), params: { organization_manage: { name: 'New name' } }, as: :json
        expect(response).to have_http_status(:forbidden)
      end

      it 'does not update the requested organization' do
        authorized_put api_v1_organization_manage_url(organization.id), params: { organization_manage: { name: 'New name' } }, as: :json
        organization.reload
        expect(organization.name).not_to eq('New name')
      end
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
