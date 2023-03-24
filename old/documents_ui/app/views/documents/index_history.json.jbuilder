# frozen_string_literal: true

json.array! @history, partial: 'documents/document_history', as: :history
