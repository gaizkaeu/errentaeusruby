module Api::V1::Services
  class EstimateService
    def call(estimation_params, raise_error: false)
      estimation = Api::V1::Estimation.new(estimation_params.merge(token: SecureRandom.base64(20)))
      if estimation.valid?
        [estimation, Api::V1::Services::EncodeEstimationService.new.call(estimation)]
      else
        raise ActiveRecord::RecordInvalid, estimation if raise_error

        [estimation, nil]
      end
    end
  end
end
