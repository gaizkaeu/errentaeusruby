# frozen_string_literal: true

json.partial! 'estimations/estimation', estimation: @estimation
json.token do
  json.data @token[:token]
  json.exp @token[:exp]
end
