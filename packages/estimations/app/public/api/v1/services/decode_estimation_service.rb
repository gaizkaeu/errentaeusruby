module Api::V1::Services
  class DecodeEstimationService
    def call(token, raise_error: false)
      decoded = JWT.decode(token, Rails.application.config.x.estimation_sign_key, true, { algorithm: 'HS512' })[0]
      [Api::V1::Estimation.new(decoded['data']), { exp: decoded['exp'], token: }]
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError => e
      raise e if raise_error

      [nil, nil]
    end
  end
end
