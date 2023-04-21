class CalcrTrainJob < ApplicationJob
  def perform(params)
    Api::V1::Services::CalcrTrainService.call(params['calculator_id'])
  end
end
