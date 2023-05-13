require 'rails_helper'

RSpec.describe 'OrganizationManage' do
  let(:user) { create(:user) }
  # rubocop:disable RSpec/IndexedLet
  let(:organization) { create(:organization, :with_memberships) }
  let(:organization2) { create(:organization, status: 'featured_city', name: 'noesesta') }
  let(:organization3) { create(:organization, status: 'featured_city') }
  # rubocop:enable RSpec/IndexedLet
  let(:organization_attributes) { attributes_for(:organization) }

  context 'with owning organization' do
    before do
      sign_in organization.memberships.first.user
    end

    describe 'SHOW /organization-manage/:id' do
      it 'renders a successful response' do
        get api_v1_org_man_url(organization.id), as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(body)['data']['id']).to eq(organization.id)
      end

      it 'renders a not found response' do
        get api_v1_org_man_url(organization3.id), as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'POST /organization-manage' do
      it 'renders a successful response' do
        post api_v1_org_man_index_url, params: { organization_manage: organization_attributes }, as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(body)['data']['id']).not_to be_nil
      end

      it 'persists the organization' do
        expect do
          post api_v1_org_man_index_url, params: { organization_manage: organization_attributes }, as: :json
        end.to change(Api::V1::Organization, :count).by(1)
      end

      it 'renders errors when invalid' do
        post api_v1_org_man_index_url, params: { organization_manage: { name: '' } }, as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(body)['name']).to be_present
      end
    end

    describe 'PATCH /organization-manage/:id' do
      it 'renders a successful response' do
        patch api_v1_org_man_url(organization.id), params: { organization_manage: { name: 'new name' } }, as: :json
        expect(response).to be_successful
        expect(body['data']).to be_present
        expect(JSON.parse(body)['data']['attributes']['name']).to eq('new name')
      end

      it 'cant update other organizations' do
        patch api_v1_org_man_url(organization3.id), params: { organization_manage: { name: 'new name' } }, as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:forbidden)
      end

      it 'renders errors when invalid' do
        patch api_v1_org_man_url(organization.id), params: { organization_manage: { name: '' } }, as: :json
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(body)['name']).to be_present
      end
    end
  end
end
