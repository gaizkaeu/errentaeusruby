# frozen_string_literal: true

json.array! @history, partial: 'api/v1/documents/document_history', as: :history
