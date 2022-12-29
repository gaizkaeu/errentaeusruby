class Api::V1::Services::AppointmentsForAccountService < ApplicationService
  def call(current_account, filters = {})
    filter_method = current_account.lawyer? ? :filter_by_lawyer_id : :filter_by_client_id
    appointments = Api::V1::AppointmentRecord.public_send(filter_method, current_account.id)
    filtered_appointments = Api::V1::AppointmentRecord.filter(filters, appointments).order(time: :desc)

    filtered_appointments.map do |a|
      Api::V1::Appointment.new(a.attributes.symbolize_keys!)
    end
  end
end
