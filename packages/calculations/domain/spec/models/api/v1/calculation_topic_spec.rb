require 'rails_helper'

RSpec.describe Api::V1::CalculationTopic do
  describe 'associations' do
    it { is_expected.to have_many(:calculators).class_name('Api::V1::Calculator') }
    it { is_expected.to have_many(:calculations).through(:calculators) }
  end
end
