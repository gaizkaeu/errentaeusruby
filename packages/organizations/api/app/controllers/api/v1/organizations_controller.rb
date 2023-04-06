# frozen_string_literal: true

class Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate, except: %i[index show reviews]
  before_action :set_organization, only: %i[show update destroy]

  def index
    pagy, orgs = pagy(Api::V1::Organization.includes([:taggings]).ransack(params[:q]).result.where(visible: true))

    render json: Api::V1::Serializers::OrganizationSerializer.new(orgs, meta: pagy_metadata(pagy))
  end

  def show
    render json: Api::V1::Serializers::OrganizationSerializer.new(@organization)
  end

  private

  def set_organization
    @organization = Api::V1::Organization.find(params[:id])

    render json: { error: 'Organization not found' }, status: :not_found unless @organization.visible
  end
end
