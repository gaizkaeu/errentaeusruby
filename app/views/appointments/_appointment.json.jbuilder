json.extract! appointment, :id, :user_id, :time, :tax_income_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
