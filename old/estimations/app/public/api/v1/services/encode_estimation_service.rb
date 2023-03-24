class Api::V1::Services::EncodeEstimationService < ApplicationService
  def call(estimation)
    exp = Time.now.to_i + (5 * 24 * 3600)
    data = { data: estimation.attributes.except('price', 'id', 'created_at', 'updated_at', 'user_id', 'tax_income_id'), exp: }
    { data: JWT.encode(data, Rails.application.config.x.estimation_sign_key, 'HS512'), exp: }
  end
end
