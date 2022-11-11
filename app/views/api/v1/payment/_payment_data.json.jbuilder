# frozen_string_literal: true

json.amount payment.amount
json.status payment.status
json.receipt_url payment.charges.data[0].receipt_url
json.card do
  json.brand payment.charges.data[0].payment_method_details.card.brand
  json.last4 payment.charges.data[0].payment_method_details.card.last4
  json.wallet payment.charges.data[0].payment_method_details.card.wallet
  json.refunded payment.charges.data[0].refunded
  json.status payment.charges.data[0].status
end
