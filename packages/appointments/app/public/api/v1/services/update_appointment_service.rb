class Api::V1::Services::UpdateAppointmentService < ApplicationService
  include Authorization

  def call(current_account, id, appointment_params, raise_error: false)
    save_method = raise_error ? :update! : :update
    appointment_record = Api::V1::AppointmentRecord.find(id)
    raise ActiveRecord::RecordNotFound unless appointment_record

    authorize_with current_account, appointment_record, :update?, policy_class: Api::V1::AppointmentPolicy

    AppointmentPubSub.publish('appointment.updated', appointment_id: appointment_record.id) if appointment_record.public_send(save_method, appointment_params)
    appointment = Api::V1::Appointment.new(appointment_record.attributes.symbolize_keys!)
    appointment.instance_variable_set(:@errors, appointment_record.errors)
    appointment
  end
end
