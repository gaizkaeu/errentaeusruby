# frozen_string_literal: true

json.partial! 'estimations/estimation', estimation: @estimation
json.token @estimation.as_estimation_jwt
