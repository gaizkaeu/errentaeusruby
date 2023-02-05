TransactionPubSub = PubSubManager.new
TransactionPubSub.register_event('transaction.created') do
  organization_id String
  trn_id String
end
TransactionPubSub.subscribe('transaction.created', OrgTrackNewTransactionJob)
