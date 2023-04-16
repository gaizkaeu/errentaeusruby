class Api::V1::CalculationTopic < ApplicationRecord
  include PrettyId

  self.id_prefix = 'calct'

  has_many :calculators, class_name: 'Api::V1::Calculator'
  has_many :calculations, through: :calculators

  def calculate(_classification)
    10
  end

  def variable_types
    prediction_attributes.each_value.to_h do |attribute|
      [attribute['name'].to_sym, attribute['var_type'].to_sym]
    end
  end

  def variable_data_types
    prediction_attributes.each_value.to_h do |attribute|
      [attribute['name'].to_sym, attribute['type'].to_sym]
    end
  end

  def attributes_training
    prediction_attributes.each_value.pluck('name')
  end

  def sanitize_variable(name, value)
    type = prediction_attributes.select { |_key, v| v['name'] == name }
                                .values.first['type']
    case type
    when 'integer'
      value.to_i
    when 'string'
      value.to_s
    end
  end
end
