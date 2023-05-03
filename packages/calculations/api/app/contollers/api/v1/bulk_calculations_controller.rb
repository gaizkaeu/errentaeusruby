# frozen_string_literal: true

module Api
  module V1
    class BulkCalculationsController < ApplicationController
      before_action :authenticate
      before_action :set_bulk_calculation

      def show
        pagy, bulk_clcn = pagy(@bulk_calculation.calculations.includes(%i[calculator organization calculation_topic]))
        render json: Api::V1::Serializers::CalculationSerializer.new(bulk_clcn, meta: pagy_metadata(pagy), **serializer_params)
      end

      private

      def serializer_params
        { params: { organization: true } }
      end

      def set_bulk_calculation
        @bulk_calculation = BulkCalculation.find_by(id: params[:id], user: current_user)
      end
    end
  end
end
