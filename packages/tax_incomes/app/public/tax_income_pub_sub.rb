TaxIncomePubSub = PubSubManager.new
TaxIncomePubSub.register_event('tax_income.created') { tax_income_id String }
TaxIncomePubSub.register_event('tax_income.payment_intent_succeeded') { tax_income_id String }
TaxIncomePubSub.register_event('tax_income.amount_captured') { tax_income_id String }
TaxIncomePubSub.register_event('tax_income.lawyer_assigned') do
  tax_income_id String
  lawyer_id String
end

TaxIncomePubSub.subscribe('tax_income.created', TaxIncomeCreatedJob)
TaxIncomePubSub.subscribe('tax_income.payment_intent_succeeded', TaxIncomePaymentSucceededJob)
TaxIncomePubSub.subscribe('tax_income.lawyer_assigned', LawyerNotificationJob)
