require 'rails_helper'

RSpec.describe 'Appointments' do
  let(:tax_income) { create(:tax_income_with_lawyer) }

  let(:valid_server_attributes) do
    { lawyer_id: tax_income.lawyer_id, client_id: tax_income.client_id, tax_income_id: tax_income.id, meeting_method: 'phone', phone: '688867636', time: '2025-11-30T11:30:00.000Z' }
  end

  let(:valid_attributes) do
    { tax_income_id: tax_income.id, meeting_method: 'phone', phone: '688867636', time: '2025-11-30T11:30:00.000Z' }
  end

  let(:invalid_attributes) do
    { tax_income_id: 9, meeting_method: 'asd', phone: '688867636' }
  end

  context 'when logged in' do
    before do
      sign_in(tax_income.client)
    end

    describe 'GET /index' do
      it 'renders a successful response' do
        tax_income.waiting_for_meeting!
        Api::V1::AppointmentRepository.add valid_server_attributes
        authorized_get api_v1_appointments_url, as: :json
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        tax_income.waiting_for_meeting!
        appointment = Api::V1::AppointmentRepository.add valid_server_attributes
        authorized_get api_v1_appointment_url(appointment)
        expect(response).to be_successful
        expect(JSON.parse(response.body).symbolize_keys!).to match(a_hash_including(valid_attributes))
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        before do
          tax_income.waiting_for_meeting!
        end

        it 'creates a new Api::V1::Appointment' do
          expect do
            authorized_post api_v1_appointments_url, params: { appointment: valid_attributes }, as: :json
          end.to change(Api::V1::AppointmentRepository, :count).by(1)
        end

        it 'renders a JSON response with the new api_v1_appointment' do
          authorized_post api_v1_appointments_url, params: { appointment: valid_attributes }, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end

      context 'with invalid parameters' do
        before do
          tax_income.waiting_for_meeting!
        end

        it 'does not create a new Api::V1::Appointment' do
          expect do
            authorized_post api_v1_appointments_url, params: { appointment: invalid_attributes }, as: :json
          end.not_to change(Api::V1::AppointmentRepository, :count)
        end

        it 'renders a JSON response with errors for the new api_v1_appointment' do
          authorized_post api_v1_appointments_url, params: { appointment: invalid_attributes }, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end
    end

    context 'with valid parameters and tax income not ready' do
      before do
        tax_income.pending_assignation!
      end

      it 'does not create a new Api::V1::Appointment' do
        expect do
          authorized_post api_v1_appointments_url, params: { appointment: valid_attributes }, as: :json
        end.not_to change(Api::V1::AppointmentRepository, :count)
      end

      it 'renders a JSON response with errors for the new api_v1_appointment' do
        authorized_post api_v1_appointments_url, params: { appointment: valid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(response.body).to match(a_string_including("tax income doesn't accept appointment"))
      end
    end

    describe 'PATCH /update' do
      let(:new_attributes) do
        { phone: '605705598' }
      end

      before do
        tax_income.waiting_for_meeting!
      end

      context 'with valid parameters' do
        it 'updates the requested api_v1_appointment' do
          appointment = Api::V1::AppointmentRepository.add valid_server_attributes
          authorized_put api_v1_appointment_url(appointment), params: { appointment: new_attributes }, as: :json
          appointment = Api::V1::AppointmentRepository.find(appointment.id)
          expect(appointment.phone).to match(new_attributes[:phone])
        end

        it 'renders a JSON response with the api_v1_appointment' do
          appointment = Api::V1::AppointmentRepository.add valid_server_attributes
          authorized_put api_v1_appointment_url(appointment), params: { appointment: new_attributes }, as: :json
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end

      context 'with invalid parameters' do
        it 'renders a JSON response with errors for the api_v1_appointment' do
          appointment = Api::V1::AppointmentRepository.add valid_server_attributes
          authorized_put api_v1_appointment_url(appointment), params: { appointment: invalid_attributes }, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end
    end
  end

  context 'when not logged in' do
    describe 'renders a error/unauthorized response' do
      it 'GET /index' do
        tax_income.waiting_for_meeting!
        Api::V1::AppointmentRepository.add valid_server_attributes
        get api_v1_appointments_url, as: :json
        expect(response.body).to match('not authorized')
        expect(response).to have_http_status(:unauthorized)
      end
    end

    it 'GET /show' do
      tax_income.waiting_for_meeting!
      appointment = Api::V1::AppointmentRepository.add valid_server_attributes
      get api_v1_appointments_url(appointment)
      expect(response.body).to match('not authorized')
      expect(response).to have_http_status(:unauthorized)
    end
  end

  # describe "DELETE /destroy" do
  #   it "destroys the requested api_v1_appointment" do
  #     appointment = Api::V1::AppointmentRepository.add valid_server_attributes
  #     expect {
  #       delete api_v1_appointment_url(appointment), headers: valid_headers, as: :json
  #     }.to change(Api::V1::AppointmentRepository, :count).by(-1)
  #   end
  # end
end
