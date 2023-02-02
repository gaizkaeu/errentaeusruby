require 'rails_helper'

RSpec.describe Api::V1::UserRecord do
  let(:user) { create(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to define_enum_for(:account_type) }
  end

  describe 'scopes' do
    describe 'filter_by_all_first_name' do
      let(:user1) { create(:user, first_name: 'John', last_name: 'Doe') }
      let(:user2) { create(:user, first_name: 'John', last_name: 'Smith') }
      let(:user3) { create(:user, first_name: 'Jane', last_name: 'Doe') }

      it 'returns users matching the first name' do
        expect(described_class.filter_by_name('John')).to match_array([user1, user2])
      end
    end

    describe 'filter_by_client_first_name' do
      let(:user1) { create(:user, first_name: 'John', last_name: 'Doe', account_type: :client) }
      let(:user2) { create(:user, first_name: 'John', last_name: 'Smith', account_type: :client) }
      let(:user3) { create(:user, first_name: 'Jane', last_name: 'Doe', account_type: :lawyer) }

      it 'returns users matching the first name' do
        expect(described_class.filter_by_client_first_name('John')).to match_array([user1, user2])
      end
    end

    describe 'filter_by_lawyer_first_name' do
      let(:user1) { create(:user, first_name: 'John', last_name: 'Doe', account_type: :lawyer) }
      let(:user2) { create(:user, first_name: 'John', last_name: 'Smith', account_type: :lawyer) }
      let(:user3) { create(:user, first_name: 'Jane', last_name: 'Doe', account_type: :client) }

      it 'returns users matching the first name' do
        expect(described_class.filter_by_lawyer_first_name('John')).to match_array([user1, user2])
      end
    end
  end
end
