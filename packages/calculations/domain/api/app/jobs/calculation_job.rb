class CalculationJob < ApplicationJob
  def perform(params)
    Api::V1::Services::CalcnPredictService.call(params['calculation_id'])
  end
end
