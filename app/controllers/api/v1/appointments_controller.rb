# frozen_string_literal: true

module Api
  module V1
    class AppointmentsController < ApiBaseController
      before_action :authenticate_api_v1_user!
      before_action :set_appointment, only: %i[show update destroy]

      after_action :verify_authorized, except: :index
      after_action :verify_policy_scoped, only: :index

      rescue_from ActiveRecord::RecordNotFound, with: :tax_income_not_found

      rescue_from ActiveRecord::RecordNotFound, with: :handler  

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

        respond_to do |format|
          if @appointment.save
            format.json { render :show, status: :created, location: @appointment }
          else
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        authorize @appointment
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
