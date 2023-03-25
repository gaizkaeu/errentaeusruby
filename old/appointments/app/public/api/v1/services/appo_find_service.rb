class Api::V1::Services::AppoFindService < ApplicationService
  include Authorization

  def call(current_account, id)
    appointment_record = Api::V1::AppointmentRecord.find(id)
    raise ActiveRecord::RecordNotFound unless appointment_record

    appointment = Api::V1::Appointment.new(appointment_record.attributes.symbolize_keys!)
    authorize_with current_account, appointment, :show?
    appointment
  end
end
