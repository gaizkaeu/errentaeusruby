module BillingService
    module StripeService
        module_function
        require 'stripe'

        def create_payment_intent(amount, metadata, customer=nil)
            # rubocop:disable Rails/SaveBang
            payment_intent = Stripe::PaymentIntent.create(
                amount:,
                currency: 'eur',
                payment_method_types: [:card],
                metadata:,
                customer:,
            )
            # rubocop:enable Rails/SaveBang
            payment_intent['client_secret']
        end
    end
end