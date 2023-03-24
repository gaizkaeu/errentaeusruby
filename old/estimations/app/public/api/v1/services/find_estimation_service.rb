class Api::V1::Services::FindEstimationService < ApplicationService
  include Authorization

  def call(_current_account, id)
    estimation = Api::V1::Estimation.find(id)
    raise ActiveRecord::RecordNotFound unless estimation

    estimation
  end
end
