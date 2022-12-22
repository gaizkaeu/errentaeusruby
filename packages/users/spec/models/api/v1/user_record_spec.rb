require 'rails_helper'

RSpec.describe Api::V1::UserRecord do
  let(:user) { create(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:account_histories) }
  end
end
