class Api::V1::Services::UpdateOrganizationService < ApplicationService
  include Authorization

  def call(current_account, organization, organization_params, raise_error: false)
    target = Api::V1::Repositories::OrganizationRepository.find(organization)
    authorize_with current_account, target, :update?
    Api::V1::Repositories::OrganizationRepository.update(organization, organization_params, raise_error:)
  end
end
