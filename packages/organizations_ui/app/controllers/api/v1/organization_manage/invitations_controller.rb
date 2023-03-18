# frozen_string_literal: true

class Api::V1::OrganizationManage::InvitationsController < ApiBaseController
  before_action :authenticate

  def index
    invitations = Api::V1::Services::OrgInvIndexService.new.call(current_user, params[:organization_manage_id])

    render json: Api::V1::Serializers::OrganizationInvitationSerializer.new(invitations)
  end

  def create
    invitation = Api::V1::Services::OrgInvCreateService.new.call(current_user, params[:organization_manage_id], invitation_params)

    if invitation.persisted?
      render json: Api::V1::Serializers::OrganizationInvitationSerializer.new(invitation), status: :created
    else
      render json: invitation.errors, status: :unprocessable_entity
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :role)
  end
end
