class Api::V1::Services::TaxPaymentCaptureService < ApplicationService
  def call(event)
    payment_intent = event[:data][:object]
    tax_income = Api::V1::TaxIncome.find_by(payment_intent_id: payment_intent[:id])
    raise ActiveRecord::RecordNotFound unless tax_income

    tax_income.update!(captured: true, amount_captured: payment_intent[:amount_capturable]).tap do
      tax_income.captured?

      tax_income.payment_succeeded!

      TaxIncomePubSub.publish('tax_income.amount_captured', tax_income_id: tax_income.id)
    end
  end
end
