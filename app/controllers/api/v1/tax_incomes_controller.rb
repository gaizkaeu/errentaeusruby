module Api::V1
  
require 'stripe'
Stripe.api_key = 'sk_test_51LxvpDGrlIhNYf6eyMiOoOdSbL3nqJzwj53cNFmE8S6ZHZrzWEE5uljuObcKniylLkgtMKgQOg2Oc865VTG0DqTd00oTgt6imP'

class TaxIncomesController < ApiBaseController
  before_action :set_tax_income, only: %i[ show edit update destroy set_appointment create_payment_intent]
  before_action :authenticate_api_v1_user!

  # GET /tax_incomes or /tax_incomes.json
  def index
    @tax_incomes = current_api_v1_user.tax_incomes.includes(:estimation).sort
  end

  # GET /tax_incomes/1 or /tax_incomes/1.json
  def show
  end

  # GET /tax_incomes/1/edit
  def edit
  end

  def set_appointment
    @appointment = Appointment.create!(lawyer: @tax_income.lawyer, client: @tax_income.user, tax_income: @tax_income, time: params[:time])
    if @appointment.save
      @tax_income.appointment_created!
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # POST /tax_incomes or /tax_incomes.json
  def create
    @tax_income = current_api_v1_user.tax_incomes.build(observations: params[:observations])

    respond_to do |format|
      if @tax_income.save
        
        @tax_income.load_price_from_estimation(Estimation.find(session[:estimation])) if session[:estimation]
        session[:estimation] = nil

        format.json {render @tax_income, status: :ok }
      else
        format.json { render json: @tax_income.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_payment_intent
    payment_intent = Stripe::PaymentIntent.create(
      amount: 1000,
      currency: 'eur',
      automatic_payment_methods: {
        enabled: true,
      },
      metadata: {
        id: @tax_income.id
      }
    )
  
    render json: {clientSecret: payment_intent['client_secret']}
  end

  # PATCH/PUT /tax_incomes/1 or /tax_incomes/1.json
  def update
    respond_to do |format|
      if @tax_income.update(tax_income_params)
        format.json { render :show, status: :ok, location: @tax_income }
      else
        format.json { render json: @tax_income.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tax_incomes/1 or /tax_incomes/1.json
  def destroy
    @tax_income.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax_income
      @tax_income = current_api_v1_user.tax_incomes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tax_income_params
      params.require(:tax_income).permit(:observations, :load_price_from_estimation)
    end
end
end