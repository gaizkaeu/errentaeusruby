class Api::V1::Services::TaxPaymentSucceededService < ApplicationService
  def call(event)
    payment_intent = event[:data][:object]
    tax_income = Api::V1::TaxIncome.find_by(payment: payment_intent[:id])
    raise ActiveRecord::RecordNotFound unless tax_income

    tax_income.update!(paid: true)

    TaxIncomePubSub.publish('tax_income.payment_intent_succeeded', tax_income_id: tax_income.id)

    return unless tax_income.payment?

    tax_income.payment_succeeded!
  end
end
