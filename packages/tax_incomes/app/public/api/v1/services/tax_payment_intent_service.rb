# rubocop:disable Rails/SaveBang
class Api::V1::Services::TaxPaymentIntentService < ApplicationService
  include Authorization

  def call(current_account, tax_income_id)
    tax_income = Api::V1::TaxIncomeRepository.find(tax_income_id)
    authorize_with current_account, tax_income, :checkout?
    return unless tax_income.price.present? && tax_income.waiting_payment?
    return retrieve_payment_intent(current_account, tax_income) if tax_income.payment.present?

    create_pi(current_account, tax_income)
  end

  private

  def retrieve_payment_intent(current_account, tax_income)
    return create_pi if tax_income.payment.nil?

    payment_intent = Stripe::PaymentIntent.retrieve(tax_income.payment)
    if payment_intent['amount'] != tax_income.price
      return create_pi(current_account, tax_income)
    end

    [payment_intent['client_secret'], payment_intent['amount']]
  end

  def create_pi(current_account, tax_income)
    payment_intent = Stripe::PaymentIntent.create({ amount: tax_income.price, currency: 'eur', payment_method_types: [:card], metadata: { type: 'tax_payment_intent', id: tax_income.id }, customer: current_account.stripe_customer_id })
    return unless tax_income.update!(payment: payment_intent['id'])

    [payment_intent['client_secret'], payment_intent['amount']]
  end
end
# rubocop:enable Rails/SaveBang
