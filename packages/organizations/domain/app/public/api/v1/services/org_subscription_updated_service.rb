class Api::V1::Services::OrgSubscriptionUpdatedService < ApplicationService
  def call(event)
    data = event[:data][:object]
    org = Api::V1::Organization.find(data[:metadata][:id])
    subscription_type = data[:items][:data].first[:plan][:metadata][:subscription_type]

    org.update!(subscription_id: data[:id], status: subscription_type)
  end
end
