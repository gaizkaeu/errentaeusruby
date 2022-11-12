class LogDocumentHistoryJob < ApplicationJob
    queue_as :default
  
    def perform(params)
        Api::V1::DocumentHistory.create!(params)
    end
  end
  