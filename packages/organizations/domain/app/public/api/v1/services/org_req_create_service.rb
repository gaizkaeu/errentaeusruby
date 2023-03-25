class Api::V1::Services::OrgReqCreateService < ApplicationService
  def call(organization_params, raise_error: false)
    save_method = raise_error ? :save! : :save
    request = Api::V1::OrganizationRequest.new(organization_params)

    request.send(save_method).tap do |_req|
      if request.persisted?
        OrganizationPubSub.publish('organization.request_created', organization_request_id: request.id)
      end
    end
  end
end
