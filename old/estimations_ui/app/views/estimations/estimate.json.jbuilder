# frozen_string_literal: true

json.partial! 'estimations/estimation', estimation: @estimation
json.token @jwt_token
