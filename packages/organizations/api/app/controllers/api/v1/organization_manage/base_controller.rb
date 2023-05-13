class Api::V1::OrganizationManage::BaseController < ApplicationController
  before_action :authenticate
  before_action :set_organization

  private

  def set_organization
    @organization = Api::V1::Organization.find(params[:org_man_id] || params[:id])

    raise Pundit::NotAuthorizedError unless current_user && @organization.user_is_admin?(current_user.id)
  end
end
