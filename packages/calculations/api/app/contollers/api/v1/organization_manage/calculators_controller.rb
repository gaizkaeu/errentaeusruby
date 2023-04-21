# frozen_string_literal: true

class Api::V1::OrganizationManage::CalculatorsController < Api::V1::OrganizationManage::BaseController
  before_action :authenticate

  def index
    calc = Api::V1::Calculator.where(organization: @organization)

    render json: Api::V1::Serializers::CalculatorSerializer.new(calc, params: { manage: true })
  end

  def show
    calc = Api::V1::Calculator.find_by(id: params[:id], organization: @organization)

    render json: Api::V1::Serializers::CalculatorSerializer.new(calc, params: { manage: true })
  end

  def train
    calc = Api::V1::Calculator.find(params[:id], organization: @organization)

    if calc.train
      render json: Api::V1::Serializers::CalculatorSerializer.new(calc, params: { manage: true })
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end
end
