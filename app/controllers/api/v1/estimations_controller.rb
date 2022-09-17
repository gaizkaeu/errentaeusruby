module Api::V1
class EstimationsController < ApplicationController
  before_action :set_estimation, only: %i[ show update destroy ]

  # GET /estimations
  def index
    @estimations = Estimation.all

    render json: @estimations
  end

  # GET /estimations/1
  def show
    render json: @estimation
  end

  # POST /estimations
  def create
    @estimation = Estimation.new(estimation_params)

    if @estimation.save
      render json: @estimation, status: :created, location: @estimation
    else
      render json: @estimation.errors, status: :unprocessable_entity
    end
  end

  def estimate
    @estimation = Estimation.new(estimation_params)

    render json: @estimation
  end

  # PATCH/PUT /estimations/1
  def update
    if @estimation.update(estimation_params)
      render json: @estimation
    else
      render json: @estimation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /estimations/1
  def destroy
    @estimation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estimation
      @estimation = Estimation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def estimation_params
      params.require(:estimation).permit(:first_name, :first_time, :home_changes, :rentals_mortgages, :professional_company_activity, :real_state_trade, :with_couple, :approved, :paid, :email, :phone)
    end
end
end