# frozen_string_literal: true

module Api
  module V1
    class AppointmentsController < ApiBaseController
      before_action :set_appointment, only: %i[show update destroy]
      before_action :authenticate_api_v1_user!

      def index
        @appointments = current_api_v1_user.appointments
      end

      def create
        @tax_income = current_api_v1_user.tax_incomes.find(params[:tax_income_id])
        @appointment = @tax_income.create_appointment(appointment_params)

        respond_to do |format|
          if @appointment.save
            format.json { render :show }
          else
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
          end
        end
      end

      def show
      end

      def destroy
      end

      def update
        respond_to do |format|
          if @appointment.update(time: params[:time], method: params[:method], phone: params[:phone])
            format.json { render :show, status: :ok }
          else
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
          end
        end
      end

      private

      def set_appointment
        @appointment = Appointment.find_by(id: params[:id])
      end

      # Only allow a list of trusted parameters through.
      def appointment_params
        params.require(:appointment).permit(:time, :method, :phone)
      end
    end
  end
end
