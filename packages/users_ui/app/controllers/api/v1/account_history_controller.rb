# frozen_string_literal: true

module Api
  module V1
    class AccountHistoryController < ::ApiBaseController
      before_action :authenticate

      def index
        actions = Api::V1::Services::IndexUserHistoryService.new.call(current_user, params[:id])
        render json: actions
      end
    end
  end
end
