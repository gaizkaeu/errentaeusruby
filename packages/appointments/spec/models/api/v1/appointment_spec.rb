require 'rails_helper'

RSpec.describe Api::V1::AppointmentRecord do
  describe '#save' do
    let(:tax_income) { create(:tax_income) }
    let(:appointment) { build(:appointment, tax_income:) }

    describe 'validations' do
      it { is_expected.to belong_to(:lawyer) }
      it { is_expected.to belong_to(:client) }
    end

    describe 'scopes' do
      describe 'filter_by_lawyer' do
        let(:lawyer) { create(:user, account_type: :lawyer) }
        let(:client) { create(:user, account_type: :client) }
        let(:appointment1) { create(:appointment, lawyer:) }
        let(:appointment2) { create(:appointment, lawyer:) }
        let(:appointment3) { create(:appointment, lawyer: client) }

        it 'returns appointments matching the lawyer' do
          expect(described_class.filter_by_lawyer_id(lawyer)).to match_array([appointment1, appointment2])
        end
      end

      describe 'filter_by_client' do
        let(:lawyer) { create(:user, account_type: :lawyer) }
        let(:client) { create(:user, account_type: :client) }
        let(:appointment1) { create(:appointment, client:) }
        let(:appointment2) { create(:appointment, client:) }
        let(:appointment3) { create(:appointment, client: lawyer) }

        it 'returns appointments matching the client' do
          expect(described_class.filter_by_client_id(client)).to match_array([appointment1, appointment2])
        end
      end

      describe 'filter_by_tax_income' do
        let(:tax_income1) { create(:tax_income) }
        let(:tax_income2) { create(:tax_income) }
        let(:appointment1) { create(:appointment, tax_income_id: tax_income1.id) }
        let(:appointment3) { create(:appointment, tax_income_id: tax_income2.id) }

        it 'returns appointments matching the tax income' do
          expect(described_class.filter_by_tax_income_id(tax_income1)).to match_array([appointment1])
        end
      end

      describe 'filter_by_past_appointments' do
        let(:appointment1) { build(:appointment, time: 1.day.ago) }
        let(:appointment2) { create(:appointment, time: 1.day.from_now) }
        let(:appointment3) { build(:appointment, time: 2.days.ago) }

        before do
          appointment1.save!(validate: false)
          appointment3.save!(validate: false)
        end

        it 'returns appointments matching the tax income' do
          expect(described_class.filter_by_past_appointments).to match_array([appointment1, appointment3])
        end
      end

      describe 'filter_by_future_appointments' do
        let(:appointment1) { build(:appointment, time: 1.day.ago) }
        let(:appointment2) { build(:appointment, time: 1.day.from_now) }
        let(:appointment3) { build(:appointment, time: 2.days.from_now) }

        before do
          appointment2.save!(validate: false)
          appointment3.save!(validate: false)
          appointment1.save!(validate: false)
        end

        it 'returns appointments matching the tax income' do
          expect(described_class.filter_by_future_appointments).to match_array([appointment2, appointment3])
        end
      end

      describe 'filter_by_day' do
        let(:appointment1) { create(:appointment, time: 1.day.ago.iso8601) }
        let(:appointment4) { build(:appointment, time: (1.day.ago.beginning_of_day + 9.hours).iso8601) }
        let(:appointment5) { build(:appointment, time: 1.day.ago.end_of_day.iso8601) }
        let(:appointment6) { create(:appointment, time: Time.now.iso8601) }

        before do
          appointment4.save!(validate: false)
          appointment5.save!(validate: false)
        end

        it 'returns appointments matching the tax income' do
          expect(described_class.filter_by_day(1.day.ago.to_s)).to match_array([appointment4])
        end
      end

      describe 'filter_by_date_range' do
        let(:appointment1) { build(:appointment, time: 1.day.ago.iso8601) }
        let(:appointment4) { build(:appointment, time: (1.day.ago.beginning_of_day + 9.hours).iso8601) }
        let(:appointment5) { build(:appointment, time: 1.day.ago.end_of_day.iso8601) }
        let(:appointment6) { create(:appointment, time: Time.now.iso8601) }

        before do
          appointment1.save!(validate: false)
          appointment4.save!(validate: false)
          appointment5.save!(validate: false)
        end

        it 'returns appointments matching the tax income' do
          expect(described_class.filter_by_date_range({ start_date: 2.days.ago.beginning_of_day.to_s, end_date: 1.day.ago.end_of_day.to_s })).to match_array([appointment1, appointment4])
        end
      end
    end

    context 'when tax income is waiting for meeting creation' do
      before do
        tax_income.update(state: 'meeting')
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
