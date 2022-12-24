require 'rails_helper'

describe Api::V1::Services::CreateAppointmentService, type: :service do
  subject(:service) { described_class.new }

  let(:user_record) { create(:user) }
  let(:user_two) { create(:user) }
  let(:tax_income) { create(:tax_income_with_lawyer, client: user_record) }
  let(:tax_income2) { create(:tax_income_with_lawyer, client: user_two) }

  let(:appointment_params_tax_income) { { tax_income_id: tax_income.id, time: '2025-11-30T11:30:00.000Z', meeting_method: 'office' } }
  let(:appointment_params) { { client_id: user_record.id, lawyer_id: tax_income.lawyer.id, time: '2025-11-30T11:30:00.000Z', meeting_method: 'office' } }

  describe '#call' do
    context 'with valid params' do
      it 'does create appointment with correct user and lawyer' do
        appointment = service.call(user_record, appointment_params_tax_income)

        expect(appointment).to be_a(Api::V1::Appointment)
        expect(appointment).to be_persisted
        expect(appointment.client_id).to be(user_record.id)
        expect(appointment.lawyer_id).to be(tax_income.lawyer.id)
        expect(appointment.tax_income_id).to be(tax_income.id)
      end

      it 'does enqueue creation job' do
        expect do
          service.call(user_record, appointment_params_tax_income)
        end.to have_enqueued_job(AppointmentCreationJob)
      end

      it 'does create appointment with correct user and lawyer but without tax_income' do
        appointment = service.call(user_record, appointment_params)

        expect(appointment).to be_a(Api::V1::Appointment)
        expect(appointment).to be_persisted
        expect(appointment.client_id).to be(user_record.id)
        expect(appointment.lawyer_id).to be(tax_income.lawyer.id)
        expect(appointment.tax_income_id).to be_nil
      end

      it 'does create appointment with correct user and lawyer but with invalid tax_income' do
        appointment = service.call(user_record, appointment_params.merge!(tax_income_id: 0))

        expect(appointment).to be_a(Api::V1::Appointment)
        expect(appointment).not_to be_persisted
        expect(appointment.client_id).to be(user_record.id)
        expect(appointment.lawyer_id).to be(tax_income.lawyer.id)
        expect(appointment.tax_income_id).to be_nil
      end
    end

    context 'with invalid params' do
      it 'does not raise error with invalid params' do
        expect do
          service.call(user_record, appointment_params.except!(:time))
        end.not_to raise_error
      end

      it 'does not enqueue creation job with invalid params' do
        expect do
          service.call(user_record, appointment_params.except!(:time))
        end.not_to have_enqueued_job(AppointmentCreationJob)
      end

      it 'does raise error with invalid params' do
        expect { service.call(user_record, appointment_params.except!(:time), raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does raise error with valid params but unauthorized tax_income' do
        expect { service.call(user_record, appointment_params.merge!({ tax_income_id: tax_income2.id }), raise_error: true) }
          .to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
