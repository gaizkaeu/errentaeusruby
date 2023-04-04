class Api::V1::WebauthnController < ApplicationController
  before_action :authenticate

  def index
    webauthn_keys = Api::V1::Services::WebauthnKeysIndex.call(current_user, params[:id])
    render json: webauthn_keys
  end
end
