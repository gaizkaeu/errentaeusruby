class Api::V1::Services::PyoCollectMonthService < ApplicationService
  def call(organization_id, date)
    date = Date.parse(date) if date.is_a?(String)

    date_start = date.beginning_of_month
    date_end = date.end_of_month

    transactions = Api::V1::Repositories::TransactionRepository.filter(organization_id:, date_start:, date_end:)

    amount = process_data(transactions)

    return if amount.nil? || amount.zero?

    create_payout(organization_id, amount, date, transactions.map(&:id))
  end

  private

  def create_payout(organization_id, amount, date, ids)
    Api::V1::Repositories::PayoutRepository.add(
      {
        organization_id:,
        amount:,
        status: :pending,
        date:,
        metadata: {
          transaction_ids: ids
        }
      },
      raise_error: true
    )
  end

  def process_data(data)
    data.reduce 0 do |sum, trn|
      case trn.status
      when 'succeeded'
        sum + trn.amount
      when 'refunded'
        sum - trn.amount
      else
        sum
      end
    end
  end
end
