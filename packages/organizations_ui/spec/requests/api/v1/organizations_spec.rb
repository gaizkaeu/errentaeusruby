require 'rails_helper'

RSpec.describe 'Organizations' do
  context 'when logged in lawyer' do
    let(:user) { create(:user) }
    let(:lawyer) { create(:lawyer) }
    let(:organization) { create(:organization, owner_id: lawyer.id) }

    let(:valid_attributes) { attributes_for(:organization) }

    before do
      sign_in(lawyer)
    end

    describe 'INDEX /organizations' do
      it 'renders a successful response' do
        authorized_get api_v1_organizations_url, as: :json
        expect(response).to be_successful
      end
    end

    describe 'SHOW /organizations/:id' do
      it 'renders a successful response' do
        authorized_get api_v1_organization_url(organization.id), as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data']['attributes'].symbolize_keys!).to match(a_hash_including(organization.attributes.slice(:name)))
      end
    end

    describe 'CREATE /organizations' do
      context 'with valid attributes' do
        it 'creates a new organization' do
          expect do
            authorized_post api_v1_organizations_url, params: { organization: valid_attributes }, as: :json
          end.to change(Api::V1::Repositories::OrganizationRepository, :count).by(1)
        end

        it 'renders a JSON response with the new organization' do
          authorized_post api_v1_organizations_url, params: { organization: valid_attributes }, as: :json
          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body)['data']['attributes'].symbolize_keys!).to match(a_hash_including(valid_attributes.slice(:name)))
        end
      end

      context 'with invalid attributes' do
        it 'renders a JSON response with errors for the new organization' do
          authorized_post api_v1_organizations_url, params: { organization: { name: '' } }, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['name']).to be_present
        end

        it 'does not create a new organization' do
          expect do
            authorized_post api_v1_organizations_url, params: { organization: { name: '' } }, as: :json
          end.not_to change(Api::V1::Repositories::OrganizationRepository, :count)
        end
      end
    end

    describe 'UPDATE /organizations/:id' do
      context 'with valid attributes' do
        let(:new_attributes) { { name: 'New name' } }

        it 'updates the requested organization' do
          authorized_put api_v1_organization_url(organization.id), params: { organization: new_attributes }, as: :json
          organization.reload
          expect(response).to be_successful
          expect(organization.name).to eq('New name')
        end

        it 'renders a JSON response with the organization' do
          authorized_put api_v1_organization_url(organization.id), params: { organization: new_attributes }, as: :json
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['data']['attributes'].symbolize_keys!).to match(a_hash_including(new_attributes.slice(:name)))
        end
      end

      context 'with invalid attributes' do
        it 'renders a JSON response with errors for the organization' do
          authorized_put api_v1_organization_url(organization.id), params: { organization: { name: '' } }, as: :json
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
          authorized_put api_v1_organization_url(organization.id), params: { organization: { name: 'New name' } }, as: :json
          expect(response).to have_http_status(:forbidden)
        end

        it 'does not update the requested organization' do
          authorized_put api_v1_organization_url(organization.id), params: { organization: { name: 'New name' } }, as: :json
          organization.reload
          expect(organization.name).not_to eq('New name')
        end
      end
    end
  end
end
