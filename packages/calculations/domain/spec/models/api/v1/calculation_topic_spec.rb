require 'rails_helper'

RSpec.describe Api::V1::CalculationTopic do
  describe 'associations' do
    it { is_expected.to have_many(:calculators).class_name('Api::V1::Calculator') }
    it { is_expected.to have_many(:calculations).through(:calculators) }
  end

  describe 'variable_types' do
    it 'returns a hash with the variable types' do
      calc_topic = create(:calculation_topic, :calct_test_schema)
      expect(calc_topic.variable_types).to eq(
        constitucion: :discrete,
        trabajadores: :continuous,
        impuestos_especiales: :discrete
      )
    end
  end

  describe 'variable_data_types' do
    it 'returns a hash with the variable data types' do
      calc_topic = create(:calculation_topic, :calct_test_schema)
      expect(calc_topic.variable_data_types).to eq(
        constitucion: :string,
        trabajadores: :integer,
        impuestos_especiales: :boolean
      )
    end
  end

  describe 'attributes_training' do
    it 'returns an array with the attributes to train' do
      calc_topic = create(:calculation_topic, :calct_test_schema)
      expect(calc_topic.attributes_training).to eq(%w[constitucion trabajadores impuestos_especiales])
    end
  end

  describe 'sanitize_variable_store' do
    let(:calc_topic) { create(:calculation_topic, :calct_test_schema) }

    it 'returns the value if it is a string' do
      expect(calc_topic.sanitize_variable_store('constitucion', 'sociedad')).to eq('sociedad')
    end

    it 'returns integer if it is a string that can be converted to integer' do
      expect(calc_topic.sanitize_variable_store('trabajadores', '3')).to eq(3)
    end

    it 'returns 0 if it is a string that cannot be converted to integer' do
      expect(calc_topic.sanitize_variable_store('trabajadores', 'foo')).to eq(0)
    end

    it 'returns the value if it is a boolean string' do
      expect(calc_topic.sanitize_variable_store('impuestos_especiales', 'true')).to be(true)
    end

    it 'returns the value if it is a boolean string (false)' do
      expect(calc_topic.sanitize_variable_store('impuestos_especiales', 'false')).to be(false)
    end

    it 'returns the value if it is a boolean' do
      expect(calc_topic.sanitize_variable_store('impuestos_especiales', true)).to be(true)
    end

    it 'returns the value if it is an integer' do
      expect(calc_topic.sanitize_variable_store('trabajadores', 3)).to eq(3)
    end
  end
end
