class Api::V1::Calculation < ApplicationRecord
  include PrettyId

  self.id_prefix = 'calcn'

  belongs_to :calculator, class_name: 'Api::V1::Calculator'

  has_one :calculation_topic, through: :calculator
  has_one :organization, through: :calculator

  belongs_to :user, class_name: 'Api::V1::User', optional: true
  belongs_to :bulk_calculation, class_name: 'Api::V1::BulkCalculation', optional: true

  delegate :calculation_topic, to: :calculator
  delegate :name, to: :calculation_topic

  validates :input, json: { message: ->(errors) { errors }, schema: -> { calculation_topic.validation_schema } }
  validates_with Api::V1::Validators::CalculationOutputValidator

  def self.ransackable_attributes(_auth_object = nil)
    %w[train_with]
  end

  before_validation do
    sanitize_input
    calculate_price
  end

  after_create_commit do
    CalculatorPubSub.publish('calculator.perform_calculation', calculation_id: id) unless train_with
  end

  def sanitize_input
    input.slice(*calculation_topic.attributes_training)

    input.each do |key, value|
      input[key] = calculation_topic.sanitize_variable_store(key, value)
    end
  end

  def stale_calculation?
    return false if output.nil?

    calculator_version != calculator.version
  end

  # rubocop:disable Metrics/AbcSize
  def eligible_for_training?
    return false if output.nil? || classification.nil? || input.nil?

    calculator.classifications.key?(classification) &&
      calculation_topic.attributes_training.all? { |k| !input.fetch(k, nil).nil? }
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def calculate_price(classification = nil)
    classification ||= self.classification
    ec = calculator.classifications.fetch(classification, nil)

    return if ec.nil? || input.nil?

    variables =
      input.select { |k, _| calculation_topic.exposed_variables.key?(k.to_sym) }
           .to_h do |key, value|
        [key.upcase, value.to_i]
      end

    self.price_result = Keisan::Calculator.new.evaluate(ec, variables)
  end
  # rubocop:enable Metrics/AbcSize

  # HELPERS

  def questions
    calculation_topic.questions.map do |question|
      question.merge('value' => input[question['name']])
    end
  end

  def classification
    output['classification']
  end
end
