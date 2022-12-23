module Api::V1::Services
  class CreateAppointmentService
    include Authorization

    def call(current_account, appointment_params, raise_error: false)
      save_method = raise_error ? :save! : :save
      params = set_params_defaults(current_account, appointment_params)

      appointment_record = Api::V1::AppointmentRecord.new(params)
      authorize_with current_account, appointment_record, :create?, policy_class: Api::V1::AppointmentPolicy

      appointment_record.public_send(save_method)

      appointment = Api::V1::Appointment.new(appointment_record.attributes.symbolize_keys!)
      appointment.instance_variable_set(:@errors, appointment_record.errors)
      appointment
    rescue ActiveRecord::RecordInvalid
      raise ActiveRecord::RecordInvalid if raise_error

      appointment = Api::V1::Appointment.new(appointment_params.except!(:tax_income_id))
      appointment.instance_variable_set(:@errors, [{ detail: 'Invalid appointment params' }])
      appointment
    end

    def set_params_defaults(current_account, appointment_params)
      if appointment_params[:tax_income_id].present?
        tax_income = Api::V1::TaxIncomeRepository.find(appointment_params[:tax_income_id])
        authorize_with current_account, tax_income, :create_appointment?
        appointment_params[:lawyer_id] = tax_income.lawyer_id
        appointment_params[:client_id] = tax_income.client_id
      end
      appointment_params
    rescue ActiveRecord::RecordNotFound
      raise ActiveRecord::RecordInvalid
    end
  end
end
