# frozen_string_literal: true

json.array! @users, partial: 'accounts/user', as: :user
