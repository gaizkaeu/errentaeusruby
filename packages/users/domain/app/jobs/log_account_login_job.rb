class LogAccountLoginJob < ApplicationJob
  def perform(params)
    Api::V1::AccountHistoryRecord.create!(params)
  end
end
