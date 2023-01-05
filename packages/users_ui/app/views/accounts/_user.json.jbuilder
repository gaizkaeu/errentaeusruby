# frozen_string_literal: true

json.extract! user, :first_name, :last_name, :account_type, :id, :email
json.has_password user.password?
