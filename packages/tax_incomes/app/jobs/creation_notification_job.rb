# frozen_string_literal: true

class CreationNotificationJob < ApplicationJob
  def perform(params)
    TaxIncomeMailer.creation(params['tax_income_id']).deliver_now!
  end
end
