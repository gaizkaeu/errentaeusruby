class Api::V1::Services::CalcnPredictService < ApplicationService
  def call(calculation_id)
    @calculation = Api::V1::Calculation.find(calculation_id)

    classify
    calculate_price

    @calculation.predicted_at = Time.zone.now

    @calculation.save!
  end

  def classify
    @classification = calculator.predict(@calculation.predict_variables)
    @calculation.output = { classification: @classification }
  end

  # rubocop:disable Metrics/AbcSize
  def calculate_price
    ec = classifications.fetch(@classification, nil)

    return 0 if ec.nil?

    int_vars = variable_data_types.select { |_, type| type == :integer }

    variables =
      @calculation.input.select { |k, _| int_vars.key?(k.to_sym) }
                  .to_h do |key, value|
        [key.upcase, value.to_i]
      end

    @calculation.price_result = Keisan::Calculator.new.evaluate(ec, variables)
  end
  # rubocop:enable Metrics/AbcSize

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
