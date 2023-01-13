require 'rails_helper'

RSpec.describe Api::V1::OrganizationRecord do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:website) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:owner).class_name('Api::V1::UserRecord') }
  end
end
