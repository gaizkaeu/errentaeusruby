# frozen_string_literal: true

json.extract! appointment, :id, :meeting_method, :tax_income_id, :time
json.phone appointment.phone if current_api_v1_user.lawyer?
