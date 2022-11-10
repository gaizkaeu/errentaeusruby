module Api::V1
  
require 'stripe'
Stripe.api_key = 'sk_test_51LxvpDGrlIhNYf6eyMiOoOdSbL3nqJzwj53cNFmE8S6ZHZrzWEE5uljuObcKniylLkgtMKgQOg2Oc865VTG0DqTd00oTgt6imP'

class TaxIncomesController < ApiBaseController
  before_action :set_tax_income, except: %i[ index create ]
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

  # POST /tax_incomes or /tax_incomes.json
  def create
    @tax_income = current_api_v1_user.tax_incomes.build(observations: params[:observations])

    respond_to do |format|
      if @tax_income.save
        
        @tax_income.load_price_from_estimation(Estimation.find(session[:estimation])) if session[:estimation]
        session[:estimation] = nil

        format.json {render :show, status: :ok }
      else
        format.json { render json: @tax_income.errors, status: :unprocessable_entity }
      end
    end
  end

  def documents
    @documents = @tax_income.documents.with_attached_files
    render "api/v1/documents/index"
  end

  def checkout
    if @tax_income.waiting_payment?
      payment_intent = Stripe::PaymentIntent.create(
        amount: @tax_income.price,
        currency: 'eur',
        payment_method_types: [:card],
        metadata: {
          id: @tax_income.id
        },
        customer: current_api_v1_user.stripe_customer_id,
      )
      render json: {clientSecret: payment_intent['client_secret']}
    else
      render json: {error: "Not able to pay"}, status: :unprocessable_entity
    end
  end

  def payment_data
    if @tax_income.payment
      payment_data = Stripe::PaymentIntent.retrieve(
        @tax_income.payment,
      )
      render partial: "api/v1/payment/payment_data", locals: {payment: payment_data}
    else
      render json: {error: "No payment data"}, status: :unprocessable_entity
    end
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
      #TODO: ACCESS PERMISSIONS
      @tax_income = TaxIncome.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tax_income_params
      params.require(:tax_income).permit(:observations)
    end
end
end