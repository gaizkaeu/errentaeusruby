# frozen_string_literal: true

json.array! @estimations, partial: 'api/v1/estimations/estimation', as: :estimation
