module Services
  module StripeWebhooks
    class PaymentSucceeded
      def call(event)
        tax_income = Api::V1::TaxIncome.find(event['data']['object']['metadata']['id'])
        tax_income.update!(payment: event['data']['object']['id'])
        tax_income.paid!
      end
    end
  end
end
