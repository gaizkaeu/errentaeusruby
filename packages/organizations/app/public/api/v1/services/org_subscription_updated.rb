class Api::V1::Services::OrgSubscriptionUpdated < ApplicationService
  def call(event)
    data = event[:data][:object]
    org = Api::V1::Repositories::OrganizationRepository.find(data[:metadata][:id])

    Api::V1::Repositories::OrganizationRepository.update(org.id, { subscription_id: data[:id], status: data[:metadata][:subscription_type] }, raise_error: true)
  end
end
