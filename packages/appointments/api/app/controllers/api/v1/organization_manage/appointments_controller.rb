class Api::V1::OrganizationManage::AppointmentsController < Api::V1::OrganizationManage::BaseController
  def index
    appos = Api::V1::Appointment.where(organization: @organization)
    render json: Api::V1::Serializers::AppointmentSerializer.new(appos, { params: { include_user: true } })
  end
end
