class Api::V1::TagsController < ApplicationController
  def index
    tags = ActsAsTaggableOn::Tag.all
    render json: Api::V1::Serializers::TagSerializer.new(tags)
  end
end
