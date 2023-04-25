# frozen_string_literal: true

class Api::V1::OrganizationManage::CalculatorsController < Api::V1::OrganizationManage::BaseController
  before_action :authenticate
  before_action :set_calculator, only: %i[show update train]

  def index
    calc = Api::V1::Calculator.includes([:calculation_topic]).where(organization: @organization)

    render json: Api::V1::Serializers::CalculatorSerializer.new(calc, params: { manage: true })
  end

  def show
    render json: Api::V1::Serializers::CalculatorSerializer.new(@calculator, params: { manage: true })
  end

  def update
    if @calculator.update(calculator_params)
      render json: Api::V1::Serializers::CalculatorSerializer.new(@calculator, params: { manage: true })
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  def train
    if @calculator.train
      render json: Api::V1::Serializers::CalculatorSerializer.new(@calculator, params: { manage: true })
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  private

  def set_calculator
    @calculator = Api::V1::Calculator.find_by(id: params[:id], organization: @organization)
  end

  def calculator_params
    params.require(:calculator).permit(classifications: {})
  end
end
