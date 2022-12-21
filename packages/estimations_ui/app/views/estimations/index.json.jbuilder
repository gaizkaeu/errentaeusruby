# frozen_string_literal: true

json.array! @estimations, partial: 'estimations/estimation', as: :estimation
