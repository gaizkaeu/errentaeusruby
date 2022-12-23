require 'rails_helper'

describe Api::V1::Services::AppointmentsForAccountService, type: :service do
  subject(:service) { described_class.new }

  let(:appointment) { create(:appointment) }

  describe '#call' do
    context 'with valid account' do
      it 'does return appointments for user' do
        res = service.call(appointment.client)

        expect(res).to be_a(Array)
        expect(res.first).to be_a(Api::V1::Appointment)
        expect(res.first.id).to be(appointment.id)
        expect(res.first.client_id).to be(appointment.client_id)
      end

      it 'does return appointments for lawyer' do
        res = service.call(appointment.lawyer)

        expect(res).to be_a(Array)
        expect(res.first).to be_a(Api::V1::Appointment)
        expect(res.first.id).to be(appointment.id)
        expect(res.first.client_id).not_to be(appointment.lawyer_id)
        expect(res.first.lawyer_id).to be(appointment.lawyer_id)
      end
    end
  end
end
