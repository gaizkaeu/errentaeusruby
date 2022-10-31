module Api::V1
    require 'stripe'
    Stripe.api_key = 'sk_test_51LxvpDGrlIhNYf6eyMiOoOdSbL3nqJzwj53cNFmE8S6ZHZrzWEE5uljuObcKniylLkgtMKgQOg2Oc865VTG0DqTd00oTgt6imP'
    endpoint_secret = 'whsec_b670d9ba2a31531921e2c1e16bbd9ac8c00b71d10bbca17f4dbb46aa52d83987'


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

        def webhook
          payload = request.body.read
          sig_header = request.env['HTTP_STRIPE_SIGNATURE']
          event = nil

          begin
              event = Stripe::Webhook.construct_event(
                  payload, sig_header, endpoint_secret
              )
          rescue JSON::ParserError => e
              # Invalid payload
              render json: "error", 400 
              return
          rescue Stripe::SignatureVerificationError => e
              # Invalid signature
              render json: "error", 400 
              return
          end

          # Handle the event
          case event.type
          when 'payment_intent.succeeded'
              payment_intent = event.data.object
              puts "llega ok"
          # ... handle other event types
          else
              puts "Unhandled event type: #{event.type}"
          end

          render json: "ok", 200 
        end
    end

end