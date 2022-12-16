module Api
  module V1
    class Estimation < ApplicationRecord
      belongs_to :tax_income, optional: true, class_name: "Api::V1::TaxIncomeRecord"

      delegate :user, to: :tax_income, allow_nil: false

      validates :first_name, length: { minimum: 5, maximum: 20 }

      # PRICE_LIST = {first_time: 15, rentals_mortgages: 20, home_changes: 50, income_rent: 25, professional_company_activity: 75,
      # real_state_trade: 40, shares_trade: 30, outside_alava: 50 }.freeze
      PRICE_LIST = { first_time: 15, home_changes: 50 }.freeze
      DISCOUNTS = { with_couple: 0.25 }.freeze
      BASE = 65

      private_constant :PRICE_LIST
      private_constant :DISCOUNTS
      private_constant :BASE

      after_initialize { calculate_price }

      def calculate_price
        price = BASE

        PRICE_LIST.each do |key, value|
          number = send(key)
          price += (number.to_i * value)
        end

        DISCOUNTS.each do |key, value|
          number = send(key)
          price -= (number.to_i * value * price)
        end
        assign_attributes({ price: })
      end

      def as_estimation_jwt
        exp = Time.now.to_i + (5 * 24 * 3600)
        data = { data: attributes.except('price', 'id', 'created_at', 'updated_at', 'user_id', 'tax_income_id'), exp: }
        { data: JWT.encode(data, Rails.application.config.x.estimation_sign_key, 'HS512'), exp: }
      end

      def self.decode_jwt_estimation(payload)
        return if payload.nil?

        decoded = JWT.decode(payload, Rails.application.config.x.estimation_sign_key, true, { algorithm: 'HS512' })[0]
        [Estimation.new(decoded['data']), { exp: decoded['exp'], token: payload }]
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        nil
      end
    end
  end
end
