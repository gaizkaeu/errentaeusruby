require 'rails_helper'

RSpec.describe Api::V1::Calculation do
  describe 'running prediction' do
    let(:calculation) { build(:calculation, :calct_test_schema) }

    it 'predicts if it is not for training' do
      calculation.input = { constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true }
      calculation.output = { classification: 'complejo1' }

      expect { calculation.save! }
        .to enqueue_job(CalcrPredictJob)
    end

    it 'does not predict if it is for training' do
      calculation.input = { constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true }
      calculation.output = { classification: 'complejo1' }
      calculation.train_with = true

      expect { calculation.save! }
        .not_to enqueue_job(CalcrPredictJob)
    end
  end

  describe 'eligibility for training' do
    let(:calculation) { build(:calculation, :calct_test_schema) }

    it 'is eligible if output, classification and input are present' do
      calculation.output = { classification: 'simple1' }
      calculation.input = { constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true }

      expect(calculation).to be_eligible_for_training
    end

    it 'is not eligible if output is missing' do
      calculation.output = nil
      calculation.input = { constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true }

      expect(calculation).not_to be_eligible_for_training
    end

    it 'is not eligible if classification is not in calculator classifications' do
      calculation.output = { classification: 'foo' }
      calculation.input = { constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true }

      expect(calculation).not_to be_eligible_for_training
    end
  end

  describe 'stale calculation' do
    let(:calculation) { build(:calculation, :calct_test_schema) }

    it 'is stale if calculator version is different' do
      calculation.calculator_version = 1
      calculation.calculator = build(:calculator, version: 2)

      expect(calculation).to be_stale_calculation
    end

    it 'is not stale if calculator version is the same' do
      calculation.calculator_version = 1
      calculation.calculator = build(:calculator, version: 1)

      expect(calculation).not_to be_stale_calculation
    end
  end

  describe 'price calculation' do
    let(:calculation) { build(:calculation, :calct_test_schema) }

    context 'with valid input and classification' do
      it 'calculates the price with output classification' do
        calculation.input = { constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true }
        calculation.output = { classification: 'complejo1' }

        # FORMULA FOR COMPLEJO1 IS: 25*TRABAJADORES+1000 = 25*3+1000 = 1075
        expect(calculation.calculate_price).to eq(1075)
        expect(calculation).to be_valid
      end

      it 'calculates the price with specified classification' do
        calculation.input = { constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true }

        # FORMULA FOR SIMPLE1 IS: 25*TRABAJADORES = 25*3 = 75

        expect(calculation.calculate_price('simple1')).to eq(75)
        expect(calculation).to be_valid
      end

      it 'updates the price with output classification' do
        calculation.input = { constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true }
        calculation.output = { classification: 'complejo1' }

        # FORMULA FOR COMPLEJO1 IS: 25*TRABAJADORES+1000 = 25*3+1000 = 1075
        expect(calculation.calculate_price).to eq(1075)
      end
    end
  end

  describe 'validate_input' do
    let(:calculation) { build(:calculation, :calct_test_schema) }

    it 'is valid if types are correct' do
      calculation.input = { constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true }

      expect(calculation).to be_valid
    end

    it 'is valid if types are incorrect but sanitization works' do
      calculation.input = { constitucion: 'sociedad', trabajadores: '3', impuestos_especiales: 1 }

      expect(calculation).to be_valid
      expect(calculation.input.symbolize_keys!).to eq({ constitucion: 'sociedad', trabajadores: 3, impuestos_especiales: true })
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
