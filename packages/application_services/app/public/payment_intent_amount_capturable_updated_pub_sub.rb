PaymentIntentAmountCapturableUpdatedPubSub = StripeCallbacksPubSubManager.new

PaymentIntentAmountCapturableUpdatedPubSub.subscribe(Api::V1::Services::TaxPaymentCaptureService, /tax_*/, synchronous: true)
