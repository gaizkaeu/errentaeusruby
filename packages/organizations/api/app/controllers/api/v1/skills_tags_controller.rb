class Api::V1::SkillsTagsController < ApplicationController
  def index
    pagy, tags = pagy(
      ActsAsTaggableOn::Tag
      .where('name LIKE ?', "%#{params[:q]}%")
      .joins(:taggings)
      .where(taggings: { context: 'skills' })
      .distinct
    )
    render json: Api::V1::Serializers::TagSerializer.new(tags, meta: pagy_metadata(pagy))
  end
end
