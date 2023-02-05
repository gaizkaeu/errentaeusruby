class Api::V1::Services::TrnCreateService < ApplicationService
  include Authorization

  def call(transaction_params, raise_error: false)
    trn = Api::V1::Repositories::TransactionRepository.add(transaction_params, raise_error:)
    if trn.persisted?
      TransactionPubSub.publish('transaction.created', organization_id: trn.organization_id, trn_id: trn.id)
    end
    trn
  end
end
