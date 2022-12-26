TaxIncomePubSub = PubSubManager.new
TaxIncomePubSub.register_event('tax_income.created') { tax_income_id Integer }
TaxIncomePubSub.register_event('tax_income.payment_intent_succeeded') { tax_income_id Integer }
TaxIncomePubSub.register_event('tax_income.lawyer_assigned') do
  tax_income_id Integer
  lawyer_id Integer
end

TaxIncomePubSub.subscribe('tax_income.created', TaxIncomeCreatedJob)
TaxIncomePubSub.subscribe('tax_income.payment_intent_succeeded', TaxIncomePaymentSucceededJob)
TaxIncomePubSub.subscribe('tax_income.lawyer_assigned', LawyerNotificationJob)
