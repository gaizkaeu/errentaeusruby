TaxIncomePubSub = PubSubManager.new
TaxIncomePubSub.register_event('tax_income.created') { tax_income_id Integer }
TaxIncomePubSub.register_event('tax_income.lawyer_assigned') do
  tax_income_id Integer
  lawyer_id Integer
end

TaxIncomePubSub.subscribe('tax_income.created', CreationNotificationJob)
TaxIncomePubSub.subscribe('tax_income.lawyer_assigned', LawyerNotificationJob)
