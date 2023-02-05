class OrgTrackNewTransactionJob < ApplicationJob
  # rubocop:disable Metrics/AbcSize
  def perform(params)
    params.symbolize_keys!
    transaction = Api::V1::Repositories::TransactionRepository.find(params[:trn_id])

    stat = Api::V1::OrganizationStatRecord.where(organization_id: transaction.metadata['organization_id'], date: transaction.created_at.to_date).first_or_initialize
    stat.balance_today += transaction.amount if transaction.status == 'succeeded'
    stat.balance_capturable_today += transaction.amount_capturable if transaction.status == 'requires_capture'
    stat.date = transaction.created_at.to_date

    stat.save!
  end
  # rubocop:enable Metrics/AbcSize
end
