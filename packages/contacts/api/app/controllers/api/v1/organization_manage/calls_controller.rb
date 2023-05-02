# frozen_string_literal: true

module Api
  module V1
    module OrganizationManage
      class CallsController < BaseController
        before_action :authenticate

        def index
          pagy, calls = pagy(
            CallContact.where(organization: @organization).includes(:calculation)
                                      .ransack(params[:q])
                                      .result
          )

          render json: Serializers::CallSerializer.new(calls, meta: pagination_meta(pagy), **serializer_config), status: :ok
        end

        def update
          call = CallContact.find_by(organization: @organization, id: params[:id])

          if call.update(call_update_params)
            render json: Serializers::CallSerializer.new(call, serializer_config), status: :ok
          else
            render json: call.errors, status: :unprocessable_entity
          end
        end

        def start
          call = CallContact.find_by(organization: @organization, id: params[:id])

          if call.start
            render json: Serializers::CallSerializer.new(call, serializer_config), status: :ok
          else
            render json: call.errors, status: :unprocessable_entity
          end
        end

        def end
          call = CallContact.find_by(organization: @organization, id: params[:id])

          if call.end
            render json: Serializers::CallSerializer.new(call, serializer_config), status: :ok
          else
            render json: call.errors, status: :unprocessable_entity
          end
        end

        private

        def serializer_config
          { params: { manage: true } }
        end

        def call_update_params
          params.require(:call).permit(:successful, :notes)
        end

        def invitation_update_params
          params.require(:invitation).permit(:role)
        end
      end
    end
  end
end
