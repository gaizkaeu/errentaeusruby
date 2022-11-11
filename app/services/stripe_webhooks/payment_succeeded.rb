module StripeWebhooks
    class PaymentSucceeded
        def call(_event)
            Rails.logger.debug "llego"
        end
    end
end