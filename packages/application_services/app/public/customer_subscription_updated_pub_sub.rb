CustomerSubscriptionUpdatedPubSub = StripeCallbacksPubSubManager.new

CustomerSubscriptionUpdatedPubSub.subscribe(Api::V1::Services::OrgSubscriptionUpdated, /org_*/, synchronous: true)
