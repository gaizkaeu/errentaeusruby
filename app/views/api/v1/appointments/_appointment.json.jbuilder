json.extract! appointment, :id, :method, :tax_income_id, :time
json.phone appointment.phone if current_api_v1_user.lawyer?