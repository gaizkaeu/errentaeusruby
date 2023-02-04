class Api::V1::Services::TrnCreateService < ApplicationService
  include Authorization

  def call(transaction_params, raise_error: false)
    Api::V1::Repositories::TransactionRepository.add(transaction_params, raise_error:)
  end
end
