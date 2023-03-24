require 'rails_helper'

RSpec.describe Api::V1::User, type: :model do
  describe 'associations' do
    it { should belong_to(:account).class_name('Account').inverse_of(:user).optional(true) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:account_type) }
    it { should validate_length_of(:first_name).is_at_least(2).is_at_most(15) }
  end

  describe 'delegations' do
    it { should delegate_method(:email).to(:account) }
  end

  describe 'methods' do
    describe '#confirmed' do
      let(:account) { create(:account, status: 'verified') }
      let(:user) { create(:user, account: account) }

      it 'returns true when the user account is verified' do
        expect(user.confirmed).to be(true)
      end

      it 'returns false when the user account is not verified' do
        account.update(status: 'unverified')
        expect(user.confirmed).to be(false)
      end
    end
  end
end