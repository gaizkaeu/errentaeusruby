# frozen_string_literal: true

class DocumentHistory < ApplicationRecord
  belongs_to :document, class_name: 'Document'
  belongs_to :user

  enum :action, {
    add_image: 0,
    remove_image: 1,
    export_requested: 2,
    completed: 5,
    created: 3
  }
end
