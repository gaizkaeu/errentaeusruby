require 'rails_helper'

describe Api::V1::Services::AppoUpdateService, type: :service do
  subject(:service) { described_class.new }

  let(:appointment) { create(:appointment) }
  let(:client_evil) { create(:user) }
  let(:valid_attributes) { { meeting_method: 'phone', phone: '0123456789' } }

  describe '#call' do
    context 'with authorized account and valid attributes' do
      it 'does update appointment' do
        res = service.call(appointment.client, appointment.id, valid_attributes)

        expect(res).to be_a(Api::V1::Appointment)
        expect(res.id).to eq(appointment.id)
        expect(res.client_id).to eq(appointment.client_id)
        expect(res.phone).to match(valid_attributes[:phone])
      end

      it 'does enqueue update job' do
        expect do
          service.call(appointment.client, appointment.id, valid_attributes)
        end.to have_enqueued_job(AppointmentUpdateJob)
      end
    end

    context 'with not authorized account and valid attributes' do
      it 'does not update appointment' do
        prev_attributes = appointment.attributes
        expect do
          service.call(client_evil, appointment.id, valid_attributes)
        end.to raise_error(Pundit::NotAuthorizedError)
        appointment.reload
        expect(appointment.attributes).to eq(prev_attributes)
      end

      it 'does not enqueue update job' do
        expect do
          expect { service.call(client_evil, appointment.id, valid_attributes) }
            .to raise_error(Pundit::NotAuthorizedError)
        end.not_to have_enqueued_job(AppointmentUpdateJob)
      end
    end

    context 'with authorized account and invalid attributes' do
      it 'does not update appointment' do
        prev_attributes = appointment.attributes
        expect do
          service.call(appointment.client, appointment.id, { meeting_method: 'invalid' }, raise_error: true)
        end.to raise_error(ActiveRecord::RecordInvalid)
        appointment.reload
        expect(appointment.attributes).to eq(prev_attributes)
      end

      it 'does not enqueue update job' do
        expect do
          service.call(appointment.client, appointment.id, { meeting_method: 'invalid' }, raise_error: false)
        end.not_to have_enqueued_job(AppointmentUpdateJob)
      end

      it 'does not update appointment and does not raise error' do
        prev_attributes = appointment.attributes
        res = service.call(appointment.client, appointment.id, { meeting_method: 'invalid' }, raise_error: false)
        expect(res).to be_a(Api::V1::Appointment)
        expect(res.id).to eq(appointment.id)
        expect(res.client_id).to eq(appointment.client_id)
        expect(res.errors.messages).to eq({ meeting_method: ['is not included in the list'] })
        appointment.reload
        expect(appointment.attributes).to eq(prev_attributes)
      end
    end
  end
end
