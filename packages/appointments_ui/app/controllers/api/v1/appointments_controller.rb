# frozen_string_literal: true

module Api
  module V1
    class AppointmentsController < ::ApiBaseController
      before_action :authenticate
      before_action :set_appointment, only: %i[show update destroy]

      def index
        appointments = Api::V1::Services::AppointmentsForAccountService.new.call(current_user, filtering_params)
        render json: Api::V1::Serializers::AppointmentSerializer.new(appointments)
      end

      def show
        render json: Api::V1::Serializers::AppointmentSerializer.new(@appointment)
      end

      def create
        appointment = Api::V1::Services::CreateAppointmentService.new.call(current_user, appointment_params)

        if appointment.persisted?
          render json: Api::V1::Serializers::AppointmentSerializer.new(appointment), status: :created, location: appointment
        else
          render json: appointment.errors, status: :unprocessable_entity
        end
      end

      def update
        appointment = Api::V1::Services::UpdateAppointmentService.new.call(current_user, params[:id], appointment_update_params, raise_error: false)
        if appointment.errors.empty?
          render json: Api::V1::Serializers::AppointmentSerializer.new(appointment), status: :ok
        else
          render json: @appointment.errors, status: :unprocessable_entity
        end
      end

      def destroy; end

      def handler
        render json: { error: 'not found' }, status: :unprocessable_entity
      end

      private

      def set_appointment
        @appointment = Api::V1::Services::FindAppointmentService.new.call(current_user, params[:id])
      end

      # Only allow a list of trusted parameters through.
      def appointment_params
        params.require(:appointment).permit(:time, :meeting_method, :phone, :tax_income_id)
      end

      def appointment_update_params
        params.require(:appointment).permit(:time, :meeting_method, :phone)
      end

      def filtering_params
        params.slice(:tax_income_id, :lawyer_id, :client_id, :day, :before_date, :after_date)
      end
    end
  end
end
