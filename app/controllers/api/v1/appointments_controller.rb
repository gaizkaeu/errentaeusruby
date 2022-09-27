module Api::V1
  class AppointmentsController < ApiBaseController
    before_action :set_appointment, only: %i[ show edit update destroy]
    before_action :authenticate_api_v1_user!

    def index
      @appointments = Appointment.find_by(client_id: current_api_v1_user.id)
    end

    def create
      @tax_income = current_api_v1_user.tax_incomes.find(params[:tax_income_id])
      @appointment = Appointment.create(client: current_api_v1_user, tax_income: @tax_income,
      lawyer_id: @tax_income.lawyer_id, time: params[:time], method: params[:method], phone: params[:phone])
      
      respond_to do |format|
        if @appointment.save
          format.json { render json: @appointment}
        else
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
        end
      end
    end

    def show
    end

    private
    def set_appointment
      @appointment = Appointment.find_by(id: params[:id], client_id: current_api_v1_user.id)
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:time, :method, :tax_income_id, :phone)
    end
  end
end