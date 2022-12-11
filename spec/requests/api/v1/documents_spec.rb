require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/api/v1/documents' do
  def upload_image_test
    Rack::Test::UploadedFile.new(File.open(Rails.public_path.join('android-chrome-192x192.png')))
  end

  # This should return the minimal set of attributes required to create a valid
  # Api::V1::Document. As you add validations to Api::V1::Document, be sure to
  # adjust the attributes here as well.
  let(:tax_income) { create(:tax_income) }

  let(:valid_attributes) do
    { tax_income_id: tax_income.id, document_number: 2, name: 'DNI' }
  end

  let(:invalid_attributes) do
    { tax_income_id: tax_income.id, name: 'DNI' }
  end

  context 'with authorized user authenticated' do
    let(:authorized_headers) { tax_income.client.create_new_auth_token }

    describe 'POST /add_document_attachment' do
      context 'with valid image' do
        it 'does upload single image' do
          document = Api::V1::Document.create! valid_attributes
          post add_document_attachment_api_v1_document_url(document), params: { 'files[0]': upload_image_test }, headers: authorized_headers
          expect(response).to be_successful
          expect(document.files.size).to match(1)
        end

        it 'does upload multiple images' do
          document = Api::V1::Document.create! valid_attributes
          post add_document_attachment_api_v1_document_url(document), params: { 'files[0]': upload_image_test, 'files[1]': upload_image_test }, headers: authorized_headers
          expect(response).to be_successful
          expect(document.files.size).to match(2)
        end

        it 'does not upload more than allowed' do
          document = Api::V1::Document.create! valid_attributes
          post add_document_attachment_api_v1_document_url(document), params: { 'files[0]': upload_image_test, 'files[1]': upload_image_test, 'files[2]': upload_image_test }, headers: authorized_headers
          expect(response).to be_successful
          expect(document.files.size).to match(2)
        end
      end
    end

    describe 'DELETE /delete_document_attachment' do
      it 'removes image' do
        document = Api::V1::Document.create! valid_attributes
        post add_document_attachment_api_v1_document_url(document), params: { 'files[0]': upload_image_test }, headers: authorized_headers
        expect(response).to be_successful
        expect(document.files.size).to match(1)
        res = JSON.parse(response.body)
        res = res['attachments'][0]['id']
        expect(res).not_to be_nil
        delete delete_document_attachment_api_v1_document_url(document, res), headers: authorized_headers
        expect(response).to be_successful
        expect(document.files.size).to match(0)
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'does not create a new Api::V1::Document' do
          expect do
            post api_v1_documents_url, params: { document: valid_attributes }, headers: authorized_headers
          end.not_to change(Api::V1::Document, :count)
          expect(response).not_to be_successful
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Api::V1::Document' do
          expect do
            post api_v1_documents_url, params: { document: invalid_attributes }, headers: authorized_headers
          end.not_to change(Api::V1::Document, :count)
          expect(response).not_to be_successful
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) do
          { tax_income_id: tax_income.id, document_number: 2, name: 'DNI2' }
        end

        it 'updates the requested api_v1_document' do
          document = Api::V1::Document.create! valid_attributes
          patch api_v1_document_url(document), params: { api_v1_document: new_attributes }, headers: authorized_headers
          document.reload
          expect(response).not_to be_successful
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested api_v1_document' do
        document = Api::V1::Document.create! valid_attributes
        expect do
          delete api_v1_document_url(document), headers: authorized_headers
        end.not_to change(Api::V1::Document, :count)
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
