class LogAccountLoginJob < ApplicationJob
    def perform(params)
        Api::V1::AccountHistory.create!(params)
    end
end
  