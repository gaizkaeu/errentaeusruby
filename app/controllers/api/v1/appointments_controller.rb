# frozen_string_literal: true

module Api
  module V1
    class AppointmentsController < ApiBaseController
      before_action :authorize_access_request!
      before_action :set_appointment, only: %i[show update destroy]

      after_action :verify_authorized, except: :index
      after_action :verify_policy_scoped, only: :index

      def index
        @appointments = policy_scope(Appointment)
      end

      def show
        authorize @appointment
      end

      def create
        @tax_income = policy_scope(TaxIncome).find(appointment_params[:tax_income_id])
        @appointment = @tax_income.build_appointment(appointment_params.except(:tax_income_id))
        authorize @appointment

        if @appointment.save
          render :show, status: :created, location: @appointment
        else
          render json: @appointment.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize @appointment
        if @appointment.update(appointment_update_params)
          render :show, status: :ok
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
        @appointment = policy_scope(Appointment).find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def appointment_params
        params.require(:appointment).permit(:time, :meeting_method, :phone, :tax_income_id)
      end

      def appointment_update_params
        params.require(:appointment).permit(:time, :meeting_method, :phone)
      end
    end
  end
end
