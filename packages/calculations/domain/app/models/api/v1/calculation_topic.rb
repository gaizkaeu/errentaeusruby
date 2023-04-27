class Api::V1::CalculationTopic < ApplicationRecord
  include PrettyId

  self.id_prefix = 'calct'

  has_many :calculators, class_name: 'Api::V1::Calculator'
  has_many :calculations, through: :calculators

  VAR_TYPES_EXPOSED = %w[integer boolean].freeze
  public_constant :VAR_TYPES_EXPOSED

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
    when 'boolean'
      value == 'true'
    end
  end

  def sanitize_training(name, value)
    type = prediction_attributes.select { |_key, v| v['name'] == name }
                                .values.first['type']
    case type
    when 'boolean'
      if value
        1
      else
        0
      end
    end
  end

  def validation_schema
    Rails.root.join('config', 'schemas', validation_file)
  end

  def estimated_time
    prediction_attributes.keys.count * 0.5
  end

  def questions
    prediction_attributes.each_value.map do |v|
      v['question'].merge!('name' => v['name'])
    end
  end

  def exposed_variables
    variable_data_types.select { |_, type| VAR_TYPES_EXPOSED.include?(type.to_s) }
  end

  def exposed_variables_formatted
    exposed_variables.transform_keys { |k| k.upcase.to_s }
  end
end
