class Api::V1::Calculation < ApplicationRecord
  include PrettyId

  self.id_prefix = 'calcn'

  belongs_to :calculator, class_name: 'Api::V1::Calculator'
  belongs_to :user, class_name: 'Api::V1::User', optional: true

  before_validation :sanitize_input

  TEST = Rails.root.join('config', 'schemas', 'test.json')
  private_constant :TEST

  validates :input, json: { schema: TEST }

  after_create_commit do
    CalculatorPubSub.publish('calculator.perform_calculation', calculation_id: id)
  end

  has_one :calculation_topic, through: :calculator

  def predict_variables
    input.values_at(*calculation_topic.attributes_training)
  end

  def sanitize_input
    input.slice(*calculation_topic.attributes_training)

    input.each do |key, value|
      input[key] = calculation_topic.sanitize_variable(key, value)
    end
  end
end
