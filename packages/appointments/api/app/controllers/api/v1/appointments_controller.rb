# frozen_string_literal: true

class Api::V1::AppointmentsController < ApiBaseController
  before_action :authenticate
  before_action :set_appointment, only: %i[show update destroy]

  def index
    appointments = Api::V1::Appointment.includes(:lawyer_profile).where(user_id: current_user.id)
    render json: Api::V1::Serializers::AppointmentSerializer.new(appointments, { params: { include_lawyer_profile: true } })
  end

  def show
    render json: Api::V1::Serializers::AppointmentSerializer.new(@appointment, { params: { include_lawyer_profile: true } })
  end

  def create
    appointment = Api::V1::Services::AppoCreateService.new.call(current_user, appointment_params)

    if appointment.persisted?
      render json: Api::V1::Serializers::AppointmentSerializer.new(appointment), status: :created, location: appointment
    else
      render json: appointment.errors, status: :unprocessable_entity
    end
  end

  def update
    appointment = Api::V1::Services::AppoUpdateService.new.call(current_user, params[:id], appointment_params, raise_error: false)
    if appointment.errors.empty?
      render json: Api::V1::Serializers::AppointmentSerializer.new(appointment), status: :ok
    else
      render json: appointment.errors, status: :unprocessable_entity
    end
  end

  def destroy; end

  def handler
    render json: { error: 'not found' }, status: :unprocessable_entity
  end

  private

  def set_appointment
    @appointment = Api::V1::Appointment.find(params[:id])
    authorize @appointment
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:time, :meeting_method, :phone, :organization_id)
  end
end
