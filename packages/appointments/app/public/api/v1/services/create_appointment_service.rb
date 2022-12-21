module Api::V1::Services
  class CreateAppointmentService
    include Authorization

    def call(current_account, appointment_params, raise_error: false)
      save_method = raise_error ? :save! : :save
      appointment = Api::V1::Appointment.new(appointment_params)
      tax_income = Api::V1::TaxIncomeRepository.find(appointment_params[:tax_income_id])
      authorize_with current_account, tax_income, :create_appointment?
      authorize_with current_account, appointment, :create?
      appointment.public_send(save_method)
      appointment
    end
  end
end
