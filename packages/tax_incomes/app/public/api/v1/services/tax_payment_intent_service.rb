# rubocop:disable Rails/SaveBang
class Api::V1::Services::TaxPaymentIntentService < ApplicationService
  include Authorization

  class InvalidPrice < StandardError; end

  def call(current_account, tax_income_id, raise_error: false)
    tax_income = Api::V1::Repositories::TaxIncomeRepository.find(tax_income_id)
    authorize_with current_account, tax_income, :checkout?

    if raise_error
      raise InvalidPrice if tax_income.price.nil? || tax_income.price <= 50
    elsif tax_income.price.nil? || tax_income.price <= 50
      return
    end

    return retrieve_payment_intent(current_account, tax_income) if tax_income.payment_intent_id.present?

    create_pi(current_account, tax_income)
  end

  private

  def retrieve_payment_intent(current_account, tax_income)
    return create_pi if tax_income.payment_intent_id.nil?

    payment_intent = Stripe::PaymentIntent.retrieve(tax_income.payment_intent_id)
    if payment_intent['amount'] != tax_income.price
      return create_pi(current_account, tax_income)
    end

    [payment_intent['client_secret'], payment_intent['amount']]
  end

  def create_pi(current_account, tax_income)
    payment_intent = Stripe::PaymentIntent.create(
      {
        amount: tax_income.price,
        currency: 'eur',
        payment_method_types: [:card],
        metadata: { type: 'tax_payment_intent', tax_income_id: tax_income.id, user_id: current_account.id, organization_id: tax_income.organization_id },
        customer: current_account.stripe_customer_id,
        capture_method: 'manual'
      }
    )
    return unless tax_income.update!(payment_intent_id: payment_intent['id'])

    [payment_intent['client_secret'], payment_intent['amount']]
  end
end
# rubocop:enable Rails/SaveBang
