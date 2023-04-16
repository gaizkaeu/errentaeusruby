class Api::V1::Calculator < ApplicationRecord
  include PrettyId
  self.id_prefix = 'calcr'

  belongs_to :calculation_topic, class_name: 'Api::V1::CalculationTopic'
  belongs_to :organization, class_name: 'Api::V1::Organization'

  delegate :name, to: :calculation_topic
  delegate :variable_data_types, to: :calculation_topic
  delegate :prediction_attributes, to: :calculation_topic
  delegate :attributes_training, to: :calculation_topic
  delegate :variable_types, to: :calculation_topic
  delegate :sanitize_variable, to: :calculation_topic

  def predictor
    # rubocop:disable Security/MarshalLoad
    @predictor ||= Marshal.load(marshalled_predictor)
    # rubocop:enable Security/MarshalLoad
  end

  def predictor=(predictor)
    self.marshalled_predictor = Marshal.dump(predictor)
  end

  delegate :predict, to: :predictor
end
