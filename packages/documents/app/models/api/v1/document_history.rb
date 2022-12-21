# frozen_string_literal: true

module Api
  module V1
    class DocumentHistory < ApplicationRecord
      belongs_to :document, class_name: 'Document'
      belongs_to :user, class_name: 'UserRecord'

      enum :action, { add_image: 0, remove_image: 1, export_requested: 2, completed: 5, created: 3 }
    end
  end
end
