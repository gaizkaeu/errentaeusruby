class Api::V1::OrganizationInvitationsController < ApiBaseController
  before_action :authenticate

  def accept
    invitation = Api::V1::Services::OrgInvAcceptService.new.call(current_user, current_account.email, params[:id])

    if invitation.errors.empty?
      render json: Api::V1::Serializers::OrganizationMembershipSerializer.new(invitation), status: :ok
    else
      render json: invitation.errors, status: :unprocessable_entity
    end
  end

  def show
    invitation = Api::V1::Repositories::OrganizationInvitationRepository.find_by!(token: params[:id])

    if invitation.expired? || invitation.email != current_account.email
      render json: { error: 'Invitation not found' }, status: :not_found
    else
      render json: Api::V1::Serializers::OrganizationInvitationSerializer.new(invitation), status: :ok
    end
  end

  def update
    invitation = Api::V1::Services::OrgInvUpdateService.new.call(
      current_user,
      params[:id],
      invitation_params,
      raise_error: false
    )

    if invitation.errors.empty?
      render json: Api::V1::Serializers::OrganizationInvitationSerializer.new(invitation), status: :ok
    else
      render json: invitation.errors, status: :unprocessable_entity
    end
  end

  private

  def invitation_params
    params.require(:organization_invitation).permit(:role)
  end
end
