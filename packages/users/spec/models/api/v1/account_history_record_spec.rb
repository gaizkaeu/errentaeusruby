require 'rails_helper'

RSpec.describe Api::V1::AccountHistoryRecord do
  let(:account_history) { create(:account_history) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:action) }
    it { is_expected.to validate_presence_of(:ip) }
    it { is_expected.to validate_presence_of(:time) }
    it { is_expected.to define_enum_for(:action).with_values(log_in: 0, refresh_token: 1, logout: 2, block: 3, updated_user: 4, registered: 5) }
  end
end
