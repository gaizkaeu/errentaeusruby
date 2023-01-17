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

  describe 'scopes' do
    describe 'filter_by_name' do
      let(:organization) { create(:organization, name: 'Organization') }
      let(:organization_two) { create(:organization, name: 'Organization Two') }

      it 'returns organizations by name' do
        expect(described_class.filter_by_name('Organization')).to eq([organization])
      end
    end

    describe 'filter_by_location' do
      let(:organization) { create(:organization, location: 'Location') }
      let(:organization_two) { create(:organization, location: 'Location Two') }

      it 'returns organizations by location' do
        expect(described_class.filter_by_location('Location')).to eq([organization])
      end
    end

    describe 'filter_by_phone' do
      let(:organization) { create(:organization, phone: '688867636') }
      let(:organization_two) { create(:organization, phone: '605705591') }

      it 'returns organizations by phone' do
        expect(described_class.filter_by_phone('688867636')).to eq([organization])
      end
    end

    describe 'filter_by_website' do
      let(:organization) { create(:organization, website: 'Website') }
      let(:organization_two) { create(:organization, website: 'Website Two') }

      it 'returns organizations by website' do
        expect(described_class.filter_by_website('Website')).to eq([organization])
      end
    end

    describe 'filter_by_owner_id' do
      let(:user) { create(:user) }
      let(:user_two) { create(:user) }
      let(:organization) { create(:organization, owner: user) }
      let(:organization_two) { create(:organization, owner: user_two) }

      it 'returns organizations by owner id' do
        expect(described_class.filter_by_owner_id(user.id)).to eq([organization])
      end
    end

    describe 'filter_by_prices' do
      let(:organization) { create(:organization, prices: { 'price' => 100 }) }
      let(:organization_two) { create(:organization, prices: { 'price' => 200 }) }

      it 'returns organizations by prices' do
        expect(described_class.filter_by_prices('price' => 100)).to eq([organization])
        expect(described_class.filter_by_prices('price' => 100)).not_to eq([organization_two])
        expect(described_class.filter_by_prices('price' => 200)).to eq([organization_two])
      end
    end
  end
end
