class Estimation < ApplicationRecord

    validates :first_name, length: { minimum: 5 }

    PRICE_LIST = {first_time: 15, rentals_mortgages: 20, home_changes: 50, income_rent: 25, professional_company_activity: 75,
    real_state_trade: 40, shares_trade: 30, outside_alava: 50 }.freeze
    DISCOUNTS = {with_couple: 0.25}.freeze
    BASE = 65.freeze

    after_initialize {calculate_price()}

    def calculate_price
        price = Estimation::BASE

        Estimation::PRICE_LIST.each do |key, value|
            number = send(key);
            price = price + (number.to_i*value)
        end

        Estimation::DISCOUNTS.each do |key, value|
            number = send(key);
            price = price - ((number.to_i*value)*price)
        end

        self.price = price
    end

end
