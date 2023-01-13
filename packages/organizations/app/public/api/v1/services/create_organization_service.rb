class Api::V1::Services::CreateOrganizationService < ApplicationService
  include Authorization

  def call(current_account, organization_params, raise_error: false)
    authorize_with current_account, Api::V1::Organization, :create?
    Api::V1::Repositories::OrganizationRepository.add(organization_params, raise_error:)
  end
end
