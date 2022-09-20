json.extract! tax_income, :id, :user_id, :estimation_id, :paid, :status, :price, :created_at, :updated_at
json.url tax_income_url(tax_income, format: :json)
