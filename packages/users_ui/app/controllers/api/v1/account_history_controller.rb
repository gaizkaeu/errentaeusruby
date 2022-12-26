# frozen_string_literal: true

module Api
  module V1
    class AccountHistoryController < ApiBaseController
      before_action :authorize_access_request!

      def index
        @actions = Api::V1::Services::IndexUserHistoryService.new.call(current_user, params[:id])
        render 'account_history/index'
      end
    end
  end
end
