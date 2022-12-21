module Services
  module BillingService
    module StripeService
      module_function

      require 'stripe'

      def create_payment_intent(amount, metadata, customer = nil)
        Stripe::PaymentIntent.create(amount:, currency: 'eur', payment_method_types: [:card], metadata:, customer:)
      end

      def retrieve_payment_intent(payment_intent)
        Stripe::PaymentIntent.retrieve(payment_intent)
      end
    end
  end
end
