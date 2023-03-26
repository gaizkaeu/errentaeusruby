require 'rails_helper'

RSpec.describe Api::V1::LawyerProfile do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to have_one_attached(:avatar) }
  end
end
