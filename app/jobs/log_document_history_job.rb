class LogDocumentHistoryJob < ApplicationJob
  
    def perform(params)
        Api::V1::DocumentHistory.create!(params)
    end
  end
  