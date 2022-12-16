# frozen_string_literal: true

json.extract! tax_income, :id, :state, :price, :created_at, :updated_at

json.client tax_income.client.id
json.year tax_income.year if tax_income.year?
json.estimation tax_income.estimation.id if tax_income.estimation.present?
json.lawyer tax_income.lawyer.id if tax_income.lawyer.present?
json.appointment tax_income.appointment.id if tax_income.appointment.present?
