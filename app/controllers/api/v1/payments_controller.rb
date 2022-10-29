module Api::V1
    require 'stripe'
    Stripe.api_key = 'sk_test_51LxvpDGrlIhNYf6eyMiOoOdSbL3nqJzwj53cNFmE8S6ZHZrzWEE5uljuObcKniylLkgtMKgQOg2Oc865VTG0DqTd00oTgt6imP'

    class PaymentsController < ApiBaseController
        def create_payment_intent
          
            # Create a PaymentIntent with amount and currency
            payment_intent = Stripe::PaymentIntent.create(
              amount: 1000,
              currency: 'eur',
              automatic_payment_methods: {
                enabled: true,
              },
            )
          
            render json: {clientSecret: payment_intent['client_secret']}
        end
    end
end