module Api::V1
    ENDPOINT_SECRET = 'whsec_b670d9ba2a31531921e2c1e16bbd9ac8c00b71d10bbca17f4dbb46aa52d83987'

    class PaymentsController < ApiBaseController
        skip_before_action :verify_authenticity_token, only: :webhook

        def webhook
          payload = request.body.read
          sig_header = request.env['HTTP_STRIPE_SIGNATURE']
          event = nil

          begin
              event = Stripe::Webhook.construct_event(
                  payload, sig_header, ENDPOINT_SECRET
              )
          rescue JSON::ParserError => e
              # Invalid payload
              render json: "error", status: 400 
              return
          rescue Stripe::SignatureVerificationError => e
              # Invalid signature
              render json: "error",  status: 400  
              return
          end

          # Handle the event
          case event.type
          when 'payment_intent.succeeded'
              payment_intent = event.data.object
              TaxIncome.find(payment_intent['metadata']['id']).paid!
          # ... handle other event types
          else
              puts "Unhandled event type: #{event.type}"
          end

          render json: "ok" 
        end
    end

end