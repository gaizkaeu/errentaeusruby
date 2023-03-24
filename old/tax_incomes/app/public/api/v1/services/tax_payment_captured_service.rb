class Api::V1::Services::TaxPaymentCapturedService < ApplicationService
  def call(event)
    payment_intent = event[:data][:object]

    log_transaction(payment_intent)

    tax_income = Api::V1::TaxIncome.find(payment_intent[:metadata][:tax_income_id])
    raise ActiveRecord::RecordNotFound unless tax_income

    tax_income.update!(captured: true, amount_captured: payment_intent[:amount_capturable]).tap do
      tax_income.captured?

      tax_income.payment_succeeded!

      TaxIncomePubSub.publish('tax_income.amount_captured', tax_income_id: tax_income.id)
    end
  end

  private

  def log_transaction(event)
    Api::V1::Services::TrnCreateService.call(
      {
        payment_intent_id: event[:id],
        amount: event[:amount],
        status: event[:status],
        user_id: event[:metadata][:user_id],
        amount_capturable: event[:amount_capturable],
        organization_id: event[:metadata][:organization_id],
        metadata: event[:metadata]
      }
    )
  end
end
