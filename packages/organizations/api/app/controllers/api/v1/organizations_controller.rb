# frozen_string_literal: true

class Api::V1::OrganizationsController < ::ApiBaseController
  before_action :authenticate, except: %i[index show reviews]
  before_action :set_organization, only: %i[show update destroy]

  def index
    pagy, orgs = pagy(Api::V1::Organization.ransack(params[:q]).result)

    render json: Api::V1::Serializers::OrganizationSerializer.new(orgs, meta: pagy_metadata(pagy))
  end

  def show
    render json: Api::V1::Serializers::OrganizationSerializer.new(@organization)
  end

  private

  def set_organization
    @organization = Api::V1::Organization.find(params[:id])
  end
end
