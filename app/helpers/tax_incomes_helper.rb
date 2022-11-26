# frozen_string_literal: true

module TaxIncomesHelper

    def parse_params(tax_income_params, estimation_token)
        estimation_attr = Api::V1::Estimation.decode_jwt_estimation(estimation_token)
        return tax_income_params if estimation_attr.nil?
        tax_income_params.merge(estimation: estimation_attr[0])
    end

end
