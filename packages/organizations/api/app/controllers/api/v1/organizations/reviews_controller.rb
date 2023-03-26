# frozen_string_literal: true

class Api::V1::Organizations::ReviewsController < ApiBaseController
  before_action :authenticate, except: :index

  def index
    reviews = Api::V1::Review.where(organization_id: params[:organization_id])
    render json: Api::V1::Serializers::ReviewSerializer.new(reviews)
  end
end
