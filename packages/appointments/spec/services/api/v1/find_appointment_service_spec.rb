require 'rails_helper'

describe Api::V1::Services::FindAppointmentService, type: :service do
  subject(:service) { described_class.new }

  let(:appointment) { create(:appointment) }
  let(:client) { create(:user) }
  let(:appointment2) { create(:appointment, client_id: client.id) }

  describe '#call' do
    context 'with authorized account' do
      it 'does return appointment' do
        res = service.call(appointment.client, appointment.id)

        expect(res).to be_a(Api::V1::Appointment)
        expect(res.id).to be(appointment.id)
        expect(res.client_id).to be(appointment.client_id)
      end

      it 'does raise error when not found' do
        expect { service.call(appointment.client, -1) }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'with unauthorized account' do
      it 'does raise error' do
        expect { service.call(appointment.client, appointment2.id) }
          .to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
