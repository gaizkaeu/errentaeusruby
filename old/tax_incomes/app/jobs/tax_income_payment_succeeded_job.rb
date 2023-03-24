# frozen_string_literal: true

class TaxIncomePaymentSucceededJob < ApplicationJob
  def perform(params)
    TaxIncomeMailer.payment_succeeded_client(params['tax_income_id']).deliver_now!
    TaxIncomeMailer.payment_succeeded_lawyer(params['tax_income_id']).deliver_now!
  end
end
