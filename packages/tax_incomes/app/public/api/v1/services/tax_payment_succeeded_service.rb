class Api::V1::Services::TaxPaymentSucceededService < ApplicationService
  def call(event)
    payment_intent = event[:data][:object]
    tax_income = Api::V1::TaxIncome.find_by(payment: payment_intent[:payment_intent][:id])
    raise ActiveRecord::RecordNotFound unless tax_income

    tax_income.update!(paid: true)

    return unless tax_income.waiting_payment?

    tax_income.payment_succeeded!
  end
end
