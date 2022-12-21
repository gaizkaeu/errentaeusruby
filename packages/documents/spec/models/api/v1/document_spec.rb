require 'rails_helper'

RSpec.describe Api::V1::Document do
  let(:tax_income) { create(:tax_income) }

  let(:valid_attributes) do
    { name: 'DNI', document_number: 2, tax_income_id: tax_income.id }
  end

  let(:invalid_attributes) do
    { name: 'DNI' }
  end

  describe 'state machine testing' do
    it 'start with pending' do
      document = described_class.new valid_attributes
      expect(document).to have_state(:pending).on(:state)
      expect(document).to have_state(:not_exported).on(:export_status)
      expect(document).to allow_transition_to(:pending).on(:state)
      expect(document).not_to allow_transition_to(:export_done).on(:export_status)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:tax_income) }
    it { is_expected.to have_many(:document_histories) }
    it { is_expected.to have_many_attached(:files) }
    it { is_expected.to have_one_attached(:exported_document) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:document_number) }
  end

  context 'with valid attributes' do
    describe 'tax_income valid' do
      it 'creates document' do
        tax_income = described_class.new valid_attributes
        expect(tax_income).to be_valid
      end
    end
  end

  context 'with invalid attributes' do
    describe 'tax_income invalid' do
      it 'creates not create document' do
        tax_income = described_class.new invalid_attributes
        expect(tax_income).not_to be_valid
      end
    end
  end
end
