class Api::V1::WebauthnController < ApiBaseController
  before_action :authenticate

  def index
    webauthn_keys = Api::V1::Services::IndexAccountWebauthnKeysService.call(current_user, params[:id])
    render json: webauthn_keys
  end
end
