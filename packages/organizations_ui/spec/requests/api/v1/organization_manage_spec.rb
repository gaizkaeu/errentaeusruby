require 'rails_helper'

RSpec.describe 'OrganizationManage' do
  let(:user) { create(:user) }
  let(:org_manage) { create(:org_manage) }
  let(:organization) { create(:organization, status: 'featured_city', name: 'hola') }
  let(:organization2) { create(:organization, status: 'featured_city', name: 'noesesta', owner_id: organization.owner_id) }
  let(:organization3) { create(:organization, status: 'featured_city') }
  let(:organization_attributes) { attributes_for(:organization, owner_id: org_manage.id) }

  context 'when not authorized user' do
    describe 'INDEX /organization-manage' do
      it 'does not render a successful response' do
        get api_v1_organization_manage_index_url, as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'SHOW /organization-manage/:id' do
      it 'does not render a successful response' do
        get api_v1_organization_manage_url(1), as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'with org_manage user' do
    before do
      sign_in organization.owner
    end

    describe 'INDEX /organization-manage' do
      it 'renders a successful response' do
        Api::V1::Repositories::OrganizationRepository.add(organization_attributes, raise_error: true)
        get api_v1_organization_manage_index_url, as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
      end

      it 'doesn\'t render other organizations' do
        get api_v1_organization_manage_index_url, as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(response.body)['data'].first['id']).to eq(organization.id)
        expect(JSON.parse(response.body)['data'].pluck('id')).not_to include(organization3.id)
      end

      it 'can query by name' do
        get api_v1_organization_manage_index_url(name: organization.name), as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(response.body)['data'].first['id']).to eq(organization.id)
        expect(JSON.parse(response.body)['data'].pluck('id')).not_to include([organization3.id, organization2.id])
      end
    end

    describe 'SHOW /organization-manage/:id' do
      it 'renders a successful response' do
        get api_v1_organization_manage_url(organization.id), as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(body)['data']['id']).to eq(organization.id)
      end

      it 'renders a not found response' do
        get api_v1_organization_manage_url(organization3.id), as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'POST /organization-manage' do
      it 'renders a successful response' do
        post api_v1_organization_manage_index_url, params: { organization_manage: organization_attributes }, as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(body)['data']['id']).not_to be_nil
      end

      it 'persists the organization' do
        expect do
          post api_v1_organization_manage_index_url, params: { organization_manage: organization_attributes }, as: :json
        end.to change(Api::V1::Repositories::OrganizationRepository, :count).by(1)
      end

      it 'cannot create a organization with other owner' do
        expect do
          post api_v1_organization_manage_index_url, params: { organization_manage: organization_attributes.merge(owner_id: user.id) }, as: :json
        end.to change(Api::V1::Repositories::OrganizationRepository, :count).by(1)
        expect(JSON.parse(body)['data']['relationships']['owner']['data']['id']).to eq(organization.owner_id.to_s)
      end

      it 'renders errors when invalid' do
        post api_v1_organization_manage_index_url, params: { organization_manage: { name: '' } }, as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(body)['name']).to be_present
      end
    end

    describe 'PATCH /organization-manage/:id' do
      it 'renders a successful response' do
        patch api_v1_organization_manage_url(organization.id), params: { organization_manage: { name: 'new name' } }, as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(body)['data']['attributes']['name']).to eq('new name')
      end

      it 'cant update other organizations' do
        patch api_v1_organization_manage_url(organization3.id), params: { organization_manage: { name: 'new name' } }, as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:forbidden)
      end

      it 'renders errors when invalid' do
        patch api_v1_organization_manage_url(organization.id), params: { organization_manage: { name: '' } }, as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(body)['name']).to be_present
      end
    end
  end

  context 'with admin user' do
    before do
      sign_in create(:user, :admin)
    end

    describe 'INDEX /organization-manage' do
      it 'renders a successful response' do
        get api_v1_organization_manage_index_url, as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
      end

      it 'can query by name' do
        get api_v1_organization_manage_index_url(name: organization.name), as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(response.body)['data'].first['id']).to eq(organization.id)
        expect(JSON.parse(response.body)['data'].pluck('id')).not_to include([organization3.id, organization2.id])
      end
    end

    describe 'SHOW /organization-manage/:id' do
      it 'renders a successful response' do
        get api_v1_organization_manage_url(organization.id), as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(body)['data']['id']).to eq(organization.id)
      end
    end

    describe 'POST /organization-manage' do
      it 'renders a successful response' do
        post api_v1_organization_manage_index_url, params: { organization_manage: organization_attributes }, as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(body)['data']['id']).not_to be_nil
      end

      it 'persists the organization' do
        expect do
          post api_v1_organization_manage_index_url, params: { organization_manage: organization_attributes }, as: :json
        end.to change(Api::V1::Repositories::OrganizationRepository, :count).by(1)
      end

      it 'can create a organization with other owner' do
        expect do
          post api_v1_organization_manage_index_url, params: { organization_manage: organization_attributes }, as: :json
        end.to change(Api::V1::Repositories::OrganizationRepository, :count).by(1)
        expect(JSON.parse(body)['data']['relationships']['owner']['data']['id']).to eq(org_manage.id.to_s)
      end
    end

    describe 'PATCH /organization-manage/:id' do
      it 'renders a successful response' do
        patch api_v1_organization_manage_url(organization.id), params: { organization_manage: { name: 'new name' } }, as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(body)['data']['attributes']['name']).to eq('new name')
      end
    end
  end
end
