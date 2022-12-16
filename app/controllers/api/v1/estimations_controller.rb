# frozen_string_literal: true

module Api
  module V1
    class EstimationsController < ApiBaseController
      before_action :authorize_access_request!, except: %i[estimate estimation_from_jwt]
      before_action :set_estimation, only: %i[show update destroy]

      # GET /estimations
      def index
        @estimations = Estimation.joins(:tax_income).where(id: current_user.id)
      end

      # GET /estimations/1
      def show; end

      def estimate
        @estimation = Estimation.new(estimation_params.merge(token: SecureRandom.base64(20)))

        if @estimation.valid?
          render :estimate
        else
          render json: @estimation.errors, status: :unprocessable_entity
        end
      end

      def estimation_from_jwt
        decoded = Estimation.decode_jwt_estimation(params[:estimation_jwt])
        @estimation = decoded[0]
        @token = decoded[1]
        if @estimation.nil?
          render json: { error: 'invalid token' }, status: :unprocessable_entity
        else
          render :estimation_from_jwt
        end
      end

      # PATCH/PUT /estimations/1
      def update
        if @estimation.update(estimation_params)
          render :show
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
        params.require(:estimation).permit(
          :first_name,
          :first_time,
          :home_changes,
          :rentals_mortgages,
          :professional_company_activity,
          :real_state_trade,
          :with_couple
        )
      end
    end
  end
end
