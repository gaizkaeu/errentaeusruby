require 'rails_helper'

RSpec.describe Api::V1::Calculation do
  describe 'validate_input' do
    let(:calculation) { build(:calculation, :calct_test_schema) }

    it 'is valid if types are correct' do
      calculation.input = { constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true }

      expect(calculation).to be_valid
    end

    it 'is valid if types are incorrect but sanitization works' do
      calculation.input = { constitucion: 'sociedad', trabajadores: '3', impuestos_especiales: '1' }

      expect(calculation).to be_valid
    end

    it 'is invalid if types are incorrect and sanitization fails' do
      calculation.input = { constitucion: 'sociedad', trabajadores: { foo: 'bar' }, impuestos_especiales: '1' }

      expect(calculation).not_to be_valid
      expect(calculation.errors[:input]).to be_present
    end

    it 'is invalid if input is missing' do
      calculation.input = nil

      expect(calculation).not_to be_valid
      expect(calculation.errors[:input]).to be_present
    end
  end
end
