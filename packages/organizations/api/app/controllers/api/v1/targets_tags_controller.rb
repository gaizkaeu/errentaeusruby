class Api::V1::TargetsTagsController < ApplicationController
  def index
    pagy, tags = pagy(
      ActsAsTaggableOn::Tag
      .where('name LIKE ?', "%#{params[:q]}%")
      .joins(:taggings)
      .where(taggings: { context: 'company_targets' })
      .distinct
    )
    render json: Api::V1::Serializers::TagSerializer.new(tags, meta: pagy_metadata(pagy))
  end
end
