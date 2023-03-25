require 'rails_helper'

RSpec.describe Api::V1::Organization do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:website) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:users).through(:memberships) }
  end
end
