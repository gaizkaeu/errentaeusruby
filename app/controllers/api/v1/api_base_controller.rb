# frozen_string_literal: true

module Api
  module V1
    class ApiBaseController < ApplicationController
      include Pundit::Authorization
      def pundit_user
        current_api_v1_user
      end
    end
  end
end
