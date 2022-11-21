module Api
  module V1
    class Estimation < ApplicationRecord
      belongs_to :tax_income, optional: true
      belongs_to :user, optional: true

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

        update!(price:)
      end

      def as_estimation_jwt
        JWT.encode(attributes.except("price", "id", "created_at", "updated_at", "user_id", "tax_income_id"), Rails.application.secrets.secret_key_base)
      end

      def self.decode_jwt_estimation(payload)
        JWT.decode(payload, Rails.application.secrets.secret_key_base)
      end
    end
  end
end
