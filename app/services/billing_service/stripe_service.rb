module BillingService
    module StripeService
        module_function
        require 'stripe'

        def create_payment_intent(amount, metadata, customer=nil)
            payment_intent = Stripe::PaymentIntent.create(
                amount:,
                currency: 'eur',
                payment_method_types: [:card],
                metadata:,
                customer:,
            )
            payment_intent['client_secret']
        end
    end
end