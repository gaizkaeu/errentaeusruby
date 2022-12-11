require 'rails_helper'

RSpec.describe Api::V1::Appointment, type: :model do
  let(:tax_income) { create(:tax_income) }
  let(:appointment) { build(:appointment, tax_income: tax_income) }

  it { is_expected.to delegate_method(:lawyer).to(:tax_income).with_arguments(allow_nil: false) }
  it { is_expected.to delegate_method(:client).to(:tax_income).with_arguments(allow_nil: false) }

  describe "#save" do
    let(:tax_income) { create(:tax_income) }
    let(:appointment) { build(:appointment, tax_income: tax_income) }

    context "when tax income is waiting for meeting creation" do
      before do
        tax_income.update(state: 'waiting_for_meeting_creation')
      end

      it "creates the appointment" do
        expect { appointment.save }.to change(Api::V1::Appointment, :count).by(1)
      end
    end

    context "when tax income is waiting for meeting" do
      before do
        tax_income.update(state: 'waiting_for_meeting_creation')
      end

      it "creates the appointment" do
        expect { appointment.save }.to change(Api::V1::Appointment, :count).by(1)
      end
    end

    context "when tax income is not waiting for meeting creation or waiting for meeting" do
      before do
        tax_income.update(state: 'finished')
      end

      it "does not create the appointment" do
        expect { appointment.save }.not_to change(Api::V1::Appointment, :count)
      end
    end
  end
end