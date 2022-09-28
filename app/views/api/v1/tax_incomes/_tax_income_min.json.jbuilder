json.extract! tax_income, :id, :state, :price, :created_at, :updated_at
if tax_income.lawyer.present?
    json.lawyer tax_income.lawyer.id
end
