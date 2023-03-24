module Api
  module V1
    class Estimation < ApplicationRecord
      include PrettyId
      self.id_prefix = 'est'
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
    end
  end
end
