# frozen_string_literal: true

json.partial! 'api/v1/estimations/estimation', estimation: @estimation
json.token @estimation.as_estimation_jwt
