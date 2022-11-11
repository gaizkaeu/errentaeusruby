# frozen_string_literal: true

module Api
  module V1
    class LawyersController < ApiBaseController
      before_action :set_lawyer
      def show
        render partial: 'api/v1/lawyers/lawyer'
      end

      private

      def set_lawyer
        @lawyer = User.find_by(id: params[:id], account_type: :lawyer)
      end

      # Only allow a list of trusted parameters through.
      def lawyer_params
        params.require(:lawyer).permit(:id)
      end
    end
  end
end
