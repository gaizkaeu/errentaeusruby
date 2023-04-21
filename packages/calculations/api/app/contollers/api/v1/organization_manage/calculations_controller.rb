# frozen_string_literal: true

class Api::V1::OrganizationManage::CalculationsController < Api::V1::OrganizationManage::BaseController
  before_action :authenticate
  before_action :set_calculator

  def index
    pagy, calc = pagy(Api::V1::Calculation.where(calculator: @calculator).includes([:calculator]).ransack(params[:q]).result.order(created_at: :desc))

    render json: Api::V1::Serializers::CalculationSerializer.new(calc, meta: pagy_metadata(pagy), params: { manage: true })
  end

  def show
    calc = Api::V1::Calculation.find(params[:id], calculator: @calculator)

    render json: Api::V1::Serializers::CalculationSerializer.new(calc, serializer_params)
  end

  def create
    calc = Api::V1::Calculation.new(calculation_params)
    calc.calculator = @calculator

    if calc.save
      render json: Api::V1::Serializers::CalculationSerializer.new(calc, serializer_params), status: :created
    else
      render json: calc.errors, status: :unprocessable_entity
    end
  end

  def update
    calc = Api::V1::Calculation.find_by(id: params[:id], calculator: @calculator)

    if calc.update(calculation_params)
      render json: Api::V1::Serializers::CalculationSerializer.new(calc, serializer_params)
    else
      render json: calc.errors, status: :unprocessable_entity
    end
  end

  private

  def serializer_params
    { params: { manage: true } }
  end

  def calculation_params
    params.require(:calculation).permit(:calculator_id, :train_with, :verified, input: {}, output: {})
  end

  def set_calculator
    @calculator = Api::V1::Calculator.find(params[:calculator_id])
  end
end
