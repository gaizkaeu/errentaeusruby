require 'rails_helper'

# rubocop:disable RSpec/MessageSpies
# rubocop:disable RSpec/MessageExpectation
RSpec.describe Api::V1::Calculator do
  describe 'associations' do
    it { is_expected.to belong_to(:calculation_topic).class_name('Api::V1::CalculationTopic') }
    it { is_expected.to belong_to(:organization).class_name('Api::V1::Organization') }
    it { is_expected.to have_many(:calculations).class_name('Api::V1::Calculation').dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:calculator_status).in_array(%w[live training error disabled waiting_for_training]) }
  end

  describe 'eligibility to train' do
    it 'is eligible if last_trained_at is nil' do
      calculator = build(:calculator, last_trained_at: nil)
      expect(calculator).to be_eligible_to_train
    end

    it 'is eligible if last_trained_at is more than 5 minutes ago' do
      calculator = build(:calculator, last_trained_at: 6.minutes.ago)
      expect(calculator).to be_eligible_to_train
    end

    it 'is not eligible if last_trained_at is less than 5 minutes ago' do
      calculator = build(:calculator, last_trained_at: 4.minutes.ago)
      expect(calculator).not_to be_eligible_to_train
    end
  end

  describe 'train' do
    it 'does not train if not eligible' do
      calculator = create(:calculator, :calct_test_schema, last_trained_at: 4.minutes.ago)
      expect(calculator).not_to receive(:save!)
      expect(calculator).not_to be_eligible_to_train
      calculator.train
      expect(calculator.calculator_status).not_to eq('waiting_for_training')
    end

    it 'trains if eligible' do
      calculator = create(:calculator, :calct_test_schema, last_trained_at: 6.minutes.ago)
      expect(calculator).to receive(:save!)
      calculator.train
    end

    it 'enqueues a job to train' do
      calculator = create(:calculator, :calct_test_schema, last_trained_at: 6.minutes.ago)
      expect { calculator.train }
        .to enqueue_job(CalcrTrainJob)
    end
  end
end

# rubocop:enable RSpec/MessageSpies
# rubocop:enable RSpec/MessageExpectation
