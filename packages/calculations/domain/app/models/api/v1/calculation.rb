class Api::V1::Calculation < ApplicationRecord
  include PrettyId

  self.id_prefix = 'calcn'

  has_one :calculation_topic, through: :calculator
  belongs_to :calculator, class_name: 'Api::V1::Calculator'
  belongs_to :user, class_name: 'Api::V1::User', optional: true

  delegate :calculation_topic, to: :calculator

  validates :input, json: { schema: -> { calculation_topic.validation_schema } }
  validates_with Api::V1::Validators::CalculationOutputValidator

  before_validation :sanitize_input

  def self.ransackable_attributes(_auth_object = nil)
    %w[train_with]
  end

  after_create_commit do
    CalculatorPubSub.publish('calculator.perform_calculation', calculation_id: id)
  end

  def predict_variables
    input.values_at(*calculation_topic.attributes_training)
  end

  def sanitize_input
    input.slice(*calculation_topic.attributes_training)

    input.each do |key, value|
      input[key] = calculation_topic.sanitize_variable(key, value)
    end
  end

  def stale_calculation?
    return false if output.nil?

    calculator_version != calculator.version
  end

  # rubocop:disable Metrics/AbcSize
  def eligible_for_training?
    return false if output.nil? || output['classification'].nil? || input.nil?

    calculator.classifications.key?(output['classification']) &&
      calculation_topic.attributes_training.all? { |k| input[k].present? }
  end
  # rubocop:enable Metrics/AbcSize

  def questions
    calculation_topic.questions.map do |question|
      question.merge('value' => input[question['name']])
    end
  end
end
