# frozen_string_literal: true

json.array! @tax_incomes, partial: 'tax_incomes/tax_income', as: :tax_income
