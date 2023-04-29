class Api::V1::Services::CalcrPredictService < ApplicationService
  def call(calculation_id)
    @calculation = Api::V1::Calculation.find(calculation_id)

    classify

    @calculation.predicted_at = Time.zone.now
    @calculation.calculator_version = @calculation.calculator.version

    @calculation.save!
  end

  private

  def classify
    sanitized_variables =
      @calculation.calculation_topic.attributes_training.map do |attribute|
        @calculation.calculation_topic.sanitize_training(attribute, @calculation.input[attribute])
      end
    @classification = calculator.predict(sanitized_variables)
    @calculation.output = { classification: @classification }
  end

  def exposed_variables
    @exposed_variables ||= @calculation.calculation_topic.exposed_variables
  end

  def classifications
    @classifications ||= @calculation.calculator.classifications
  end

  def variable_data_types
    @variable_data_types ||= @calculation.calculation_topic.variable_data_types
  end

  def calculator
    @calculator ||= @calculation.calculator
  end
end
