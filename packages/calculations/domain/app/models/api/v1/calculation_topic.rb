class Api::V1::CalculationTopic < ApplicationRecord
  include PrettyId

  self.id_prefix = 'calct'

  has_many :calculators, class_name: 'Api::V1::Calculator'
  has_many :calculations, through: :calculators

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

  def validation_schema
    Rails.root.join('config', 'schemas', validation_file)
  end

  def questions
    prediction_attributes.each_value.pluck('question')
  end

  def exposed_variables
    variable_data_types.select { |_, type| type == :integer }
  end

  def exposed_variables_formatted
    exposed_variables.transform_keys { |k| k.upcase.to_s }
  end
end
