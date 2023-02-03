require 'rails_helper'

RSpec.describe Api::V1::LawyerProfileRecord do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to define_enum_for(:org_status) }
    it { is_expected.to define_enum_for(:lawyer_status) }
    it { is_expected.to have_one_attached(:avatar) }
    it { is_expected.to have_readonly_attribute(:user_id) }
    it { is_expected.to have_readonly_attribute(:organization_id) }

    context 'with deleted lawyer' do
      let(:lawyer_profile) { create(:lawyer_profile, lawyer_status: 'deleted') }

      it 'does not allow to update lawyer_profile' do
        expect { lawyer_profile.update!(tax_income_count: 2) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does allow to restore lawyer_profile' do
        expect { lawyer_profile.update!(lawyer_status: 'on_duty') }
          .not_to raise_error
      end
    end

    context 'with accepted org_status' do
      let(:lawyer_profile) { create(:lawyer_profile, org_status: 'accepted') }

      it 'does not allow to update org_status' do
        expect { lawyer_profile.update!(org_status: 'pending') }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does allow to update lawyer_status' do
        expect { lawyer_profile.update!(lawyer_status: 'on_duty') }
          .not_to raise_error
      end

      it 'does allow to delete lawyer_profile' do
        expect { lawyer_profile.update!(lawyer_status: 'deleted') }
          .not_to raise_error
      end
    end
  end

  describe 'default values' do
    it 'has default org_status' do
      expect(described_class.new.org_status).to eq('pending')
    end

    it 'has default lawyer_status' do
      expect(described_class.new.lawyer_status).to eq('off_duty')
    end
  end

  describe 'scopes' do
    describe 'filter_by_organization_id' do
      let(:organization) { create(:organization) }
      let(:organization_two) { create(:organization) }
      let(:lawyer_profile) { create(:lawyer_profile, organization:) }
      let(:lawyer_profile_two) { create(:lawyer_profile, organization: organization_two) }

      it 'returns lawyer profiles by organization id' do
        expect(described_class.filter_by_organization_id(organization.id)).to eq([lawyer_profile])
      end
    end

    describe 'filter_by_org_status_multiple' do
      let(:lawyer_profile) { create(:lawyer_profile, org_status: :accepted) }
      let(:lawyer_profile_two) { create(:lawyer_profile, org_status: :pending) }

      it 'returns lawyer profiles by organization status' do
        expect(described_class.filter_by_org_status(%i[accepted pending])).to include(lawyer_profile, lawyer_profile_two)
      end
    end

    describe 'filter_by_org_status' do
      let(:lawyer_profile) { create(:lawyer_profile, org_status: :accepted) }
      let(:lawyer_profile_two) { create(:lawyer_profile, org_status: :pending) }

      it 'returns lawyer profiles by organization status' do
        expect(described_class.filter_by_org_status(:accepted)).to include(lawyer_profile)
        expect(described_class.filter_by_org_status(:pending)).to include(lawyer_profile_two)
      end
    end

    describe 'filter_by_lawyer_status' do
      let(:lawyer_profile) { create(:lawyer_profile, lawyer_status: :on_duty) }
      let(:lawyer_profile_two) { create(:lawyer_profile, lawyer_status: :off_duty) }

      it 'returns lawyer profiles by lawyer status' do
        expect(described_class.filter_by_lawyer_status(:on_duty)).to include(lawyer_profile)
        expect(described_class.filter_by_lawyer_status(:off_duty)).to include(lawyer_profile_two)
      end
    end

    describe 'filter_by_user_id' do
      let(:user) { create(:user) }
      let(:user_two) { create(:user) }
      let(:lawyer_profile) { create(:lawyer_profile, user:) }
      let(:lawyer_profile_two) { create(:lawyer_profile, user: user_two) }

      it 'returns lawyer profiles by user id' do
        expect(described_class.filter_by_user_id(user.id)).to eq([lawyer_profile])
      end
    end
  end
end
