require 'stripe'
module Api::V1
    module Stripe
        Stripe.api_key = 'sk_test_51LxvpDGrlIhNYf6eyMiOoOdSbL3nqJzwj53cNFmE8S6ZHZrzWEE5uljuObcKniylLkgtMKgQOg2Oc865VTG0DqTd00oTgt6imP'

        def create_payment_intent(amount, metadata, customer?)
            payment_intent = Stripe::PaymentIntent.create(
                amount: amount,
                currency: 'eur',
                payment_method_types: [:card],
                metadata: metadata
                customer: customer,
            )
            return payment_intent['client_secret']
        end
    end
end