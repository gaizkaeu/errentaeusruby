class Api::V1::Services::CalcnPreviewService < ApplicationService
  def call(calcn_params)
    calcn = Api::V1::Calculation.new(calcn_params)

    results =
      calcn.calculator.classifications.map do |classification, _value|
        [classification, calcn.calculate_price(classification)]
      end

    results.to_h.merge(valid: calcn.eligible_for_training?)
  end
end
