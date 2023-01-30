class Api::V1::Services::OrgSubscriptionDeleted < ApplicationService
  def call(event)
    data = event[:data][:object]
    org = Api::V1::Repositories::OrganizationRepository.find(data[:metadata][:id])

    Api::V1::Repositories::OrganizationRepository.update(org.id, { subscription_id: data[:id], status: :not_subscribed }, raise_error: true)
  end
end
