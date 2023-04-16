# frozen_string_literal: true

class Api::V1::OrganizationManage::CalculationsController < Api::V1::OrganizationManage::BaseController
  before_action :authenticate
  before_action :set_calculator

  def index
    pagy, calc = pagy(Api::V1::Calculation.where(calculator: @calculator))

    render json: Api::V1::Serializers::CalculationSerializer.new(calc, meta: pagy_metadata(pagy))
  end

  private

  def set_calculator
    @calculator = Api::V1::Calculator.find(params[:calculator_id])
  end
end
