class Api::V1::Services::OrgCreateService < ApplicationService
  include Authorization

  def call(current_account, organization_params, raise_error: false)
    save_method = raise_error ? :save! : :save
    authorize_with current_account, Api::V1::Organization, :create?

    org = Api::V1::Organization.new(organization_params)

    Api::V1::Organization.transaction do
      org.public_send(save_method)
      membership = Api::V1::OrganizationMembership.new(
        user_id: current_account.id,
        organization_id: org.id,
        role: 'admin'
      )
      membership.public_send(save_method)

      org.errors.merge!(membership.errors) unless membership.persisted?

      raise ActiveRecord::Rollback unless org.persisted? && membership.persisted?
    end

    org
  end
end
