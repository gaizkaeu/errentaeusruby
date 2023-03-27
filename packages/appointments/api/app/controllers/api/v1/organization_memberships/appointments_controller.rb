class Api::V1::OrganizationMemberships::AppointmentsController < ApiBaseController
  before_action :authenticate
  before_action :set_membership

  def index
    appos = Api::V1::Appointment.where(organization_membership: @membership)

    render json: Api::V1::Serializers::AppointmentSerializer.new(appos)
  end

  private

  def set_membership
    @membership = Api::V1::OrganizationMembership.find(params[:organization_membership_id])
    authorize @membership, :own?
  end
end
