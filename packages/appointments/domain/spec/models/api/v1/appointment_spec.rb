require 'rails_helper'

RSpec.describe Api::V1::Appointment do
  describe 'validations' do
    it { is_expected.to belong_to(:user) }
  end
end
