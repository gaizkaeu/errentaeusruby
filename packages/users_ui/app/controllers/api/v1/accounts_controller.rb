# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ::ApiBaseController
      before_action :authenticate

      def index
        authorize Api::V1::User, :index?
        users = Api::V1::Services::UserFindService.new.call(current_user, filtering_params)
        render json: Api::V1::Serializers::UserSerializer.new(users).serializable_hash
      end

      def show
        user = Api::V1::Services::UserFindService.new.call(current_user, filtering_params, params[:id])
        render json: Api::V1::Serializers::UserSerializer.new(user).serializable_hash
      end

      def me
        user = current_user
        render json: Api::V1::Serializers::UserSerializer.new(user).serializable_hash
      end

      # rubocop:disable Rails/SaveBang
      def stripe_customer_portal
        portal = Stripe::BillingPortal::Session.create(
          {
            customer: current_user.stripe_customer_id,
            return_url: params[:return_url]
          }
        )
        render json: { url: portal.url }
      end
      # rubocop:enable Rails/SaveBang

      def update
        user = Api::V1::Services::UserUpdateService.new.call(current_user, params[:id], user_update_params)
        if user.errors.any?
          render json: user.errors, status: :unprocessable_entity
        else
          render json: Api::V1::Serializers::UserSerializer.new(user).serializable_hash
        end
      end

      private

      def user_update_params
        params.require(:user).permit(UserPolicy.new(current_user, nil).permitted_attributes_update)
      end

      def filtering_params
        params.slice(*Api::V1::Repositories::UserRepository::FILTER_KEYS)
      end
    end
  end
end
