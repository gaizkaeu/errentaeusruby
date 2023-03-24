# frozen_string_literal: true

json.amount payment.amount
json.status payment.status
json.charges(payment.charges.data) do |charge|
  json.charge_id charge.id
  json.receipt_url charge.receipt_url
  json.status charge.status
  json.amount charge.amount
  json.card do
    json.brand charge.payment_method_details.card.brand
    json.last4 charge.payment_method_details.card.last4
    json.wallet charge.payment_method_details.card.wallet
    json.refunded charge.refunded
  end
end
