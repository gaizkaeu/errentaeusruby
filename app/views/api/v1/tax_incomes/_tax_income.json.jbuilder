json.extract! tax_income, :id, :paid, :state, :price, :created_at, :updated_at
json.estimation tax_income.estimation

if tax_income.lawyer.present?
    json.lawyer do
        json.partial! partial: 'api/v1/user/lawyer', lawyer: tax_income.lawyer
    end
end
