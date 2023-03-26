class Api::V1::Services::OrgSubscriptionDeletedService < ApplicationService
  def call(event)
    data = event[:data][:object]
    org = Api::V1::Organization.find(data[:metadata][:id])

    org.update!(subscription_id: nil, status: :not_subscribed)
  end
end
