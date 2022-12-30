# frozen_string_literal: true

module Api
  module V1
    class EstimationsController < ::ApplicationController
      before_action :authenticate, except: %i[estimate estimation_from_jwt]
      before_action :set_estimation, only: %i[show update destroy]

      # GET /estimations/1
      def show
        render 'estimations/show'
      end

      def estimate
        @estimation, @jwt_token = Api::V1::Services::EstimateService.new.call(estimation_params)

        if @estimation.valid?
          render 'estimations/estimate'
        else
          render json: @estimation.errors, status: :unprocessable_entity
        end
      end

      def estimation_from_jwt
        @estimation, @token = Api::V1::Services::DecodeEstimationService.new.call(params[:estimation_jwt])
        if @estimation.nil?
          render json: { error: 'invalid token' }, status: :unprocessable_entity
        else
          render 'estimations/estimation_from_jwt'
        end
      end

      # PATCH/PUT /estimations/1
      def update
        if @estimation.update(estimation_params)
          render 'estimations/show'
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
        @estimation = Api::V1::Services::FindEstimationService.new.call(current_user, params[:id])
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
