module Api::V1
class TaxIncomesController < ApplicationController
  before_action :set_tax_income, only: %i[ show edit update destroy ]
  before_action :authenticate_api_v1_user!
  respond_to :json

  # GET /tax_incomes or /tax_incomes.json
  def index
    @tax_incomes = current_api_v1_user.tax_incomes.includes(:estimation)
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

        format.json {render @tax_income, status: :ok }
      else
        format.json { render json: @tax_income.errors, status: :unprocessable_entity }
      end
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
      @tax_income = current_api_v1_user.tax_incomes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tax_income_params
      params.require(:tax_income).permit(:observations, :load_price_from_estimation)
    end
end
end