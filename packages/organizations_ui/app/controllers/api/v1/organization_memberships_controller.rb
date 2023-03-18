class Api::V1::OrganizationMembershipsController < ApiBaseController
  before_action :authenticate

  def update
    membership = Api::V1::Services::OrgMemUpdateService.new.call(
      current_user,
      params[:id],
      membership_params,
      raise_error: false
    )

    if membership.errors.empty?
      render json: Api::V1::Serializers::OrganizationMembershipSerializer.new(membership), status: :ok
    else
      render json: membership.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if Api::V1::Services::OrgMemDestroyService.new.call(current_user, params[:id])
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def membership_params
    params.require(:organization_membership).permit(:role)
  end
end
