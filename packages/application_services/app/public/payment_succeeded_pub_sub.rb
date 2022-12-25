PaymentSucceededPubSub = StripeCallbacksPubSubManager.new

PaymentSucceededPubSub.subscribe(Api::V1::Services::TaxPaymentSucceededService, /tax_*/, synchronous: true)
