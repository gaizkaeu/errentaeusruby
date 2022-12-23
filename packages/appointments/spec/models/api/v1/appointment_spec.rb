require 'rails_helper'

RSpec.describe Api::V1::Appointment do
  describe '#save' do
    let(:tax_income) { create(:tax_income) }
    let(:appointment) { build(:appointment, tax_income:) }

    context 'when tax income is waiting for meeting creation' do
      before do
        tax_income.update(state: 'waiting_for_meeting')
      end

      it 'creates the appointment' do
        expect { appointment.save }
          .to change(Api::V1::AppointmentRepository, :count).by(1)
      end
    end

    context 'when tax income is not waiting for meeting creation or waiting for meeting' do
      before do
        tax_income.update(state: 'finished')
      end

      it 'does not create the appointment' do
        expect { appointment.save }
          .not_to change(Api::V1::AppointmentRepository, :count)
      end
    end
  end
end
