# frozen_string_literal: true

module Api
  module V1
    class AppointmentsController < ApiBaseController
      before_action :set_appointment, only: %i[show update destroy]
      before_action :authenticate_api_v1_user!
      rescue_from ActiveRecord::RecordNotFound, with: :handler  

      def index
        @appointments = current_api_v1_user.appointments
      end

      def show
      end

      def create
        @tax_income = current_api_v1_user.tax_incomes.find(appointment_params[:tax_income_id])
        @appointment = @tax_income.build_appointment(appointment_params.except(:tax_income_id))

        respond_to do |format|
          if @appointment.save
            format.json { render :show, status: :created, location: @appointment }
          else
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        respond_to do |format|
          if @appointment.update(appointment_update_params)
            format.json { render :show, status: :ok }
          else
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
      end

      def handler
        render json: {error: "not found"}, status: :unprocessable_entity
      end

      private

      def set_appointment
        @appointment = current_api_v1_user.appointments.find_by(id: params[:id])
      end

      # Only allow a list of trusted parameters through.
      def appointment_params
        params.require(:appointment).permit(:time, :method, :phone, :tax_income_id)
      end
      def appointment_update_params
        params.require(:appointment).permit(:time, :method, :phone)
      end
    end
  end
end
