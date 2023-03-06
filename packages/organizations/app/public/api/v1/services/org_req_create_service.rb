class Api::V1::Services::OrgReqCreateService < ApplicationService
  def call(organization_params, raise_error: false)
    request = Api::V1::Repositories::OrganizationRequestRepository.add(organization_params, raise_error:)
    if request.persisted?
      OrganizationPubSub.publish('organization.request_created', organization_request_id: request.id)
    end
    request
  end
end
