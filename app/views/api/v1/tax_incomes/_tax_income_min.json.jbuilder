# frozen_string_literal: true

json.extract! tax_income, :id, :state, :price, :created_at, :updated_at
json.lawyer tax_income.lawyer.id if tax_income.lawyer.present?
json.client tax_income.client.id
json.year tax_income.year if tax_income.year?
