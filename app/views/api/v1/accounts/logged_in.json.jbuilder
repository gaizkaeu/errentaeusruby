# frozen_string_literal: true

if @current_user.present?
  json.partial! 'api/v1/users/user', user: @current_user
end
