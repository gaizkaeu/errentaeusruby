module Api::V1::Services
  class EstimateService
    def call(estimation_params)
      estimation = Api::V1::Estimation.new(estimation_params.merge(token: SecureRandom.base64(20)))
      [estimation, Api::V1::Services::EncodeEstimationService.new.call(estimation)]
    end
  end
end
