# frozen_string_literal: true

module Api
  module V1
    class CalculationsController < ApplicationController
      before_action :authenticate
      before_action :set_calculation, except: %i[create]

      def create
        calculation = Calculation.new(create_params)
        calculation.user = current_user
        calculation.save!

        render json: Serializers::CalculationSerializer.new(calculation)
      end

      def show
        render json: Serializers::CalculationSerializer.new(@calculation)
      end

      def bulk
        bulk_c = Services::BcalcFromCalcnService.call(@calculation)
        render json: Serializers::CalculationSerializer.new(bulk_c)
      end

      private

      def create_params
        params.require(:calculation).permit(:calculator_id, input: {})
      end

      def set_calculation
        @calculation = Calculation.find_by(id: params[:id], user: current_user)
      end
    end
  end
end
