# frozen_string_literal: true

if api_v1_user_signed_in?
  json.logged_in true
  json.user do
    json.partial! 'api/v1/users/user', user: current_api_v1_user
  end
else
  json.logged_in false
end
