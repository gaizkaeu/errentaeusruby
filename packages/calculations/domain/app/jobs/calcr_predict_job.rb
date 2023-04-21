class CalcrPredictJob < ApplicationJob
  def perform(params)
    Api::V1::Services::CalcrPredictService.call(params['calculation_id'])
  end
end
