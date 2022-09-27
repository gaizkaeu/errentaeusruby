json.extract! tax_income, :id ,:state, :price, :created_at, :updated_at

if tax_income.estimation.present?
    json.estimation tax_income.estimation.id
end
if tax_income.lawyer.present?
    json.lawyer tax_income.lawyer.id
end
if tax_income.appointment.present?
    json.appointment tax_income.appointment.id
end
