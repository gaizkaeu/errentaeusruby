# frozen_string_literal: true

if api_v1_user_signed_in?
  json.partial! 'api/v1/users/user', user: current_api_v1_user
end
