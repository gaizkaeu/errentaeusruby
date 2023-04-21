# frozen_string_literal: true

class Api::V1::CalculationsController < ApplicationController
  before_action :authenticate

  def create
    calculation = Api::V1::Calculation.new(create_params)
    calculation.user = @current_user
    calculation.save!

    render json: Api::V1::Serializers::CalculationSerializer.new(calculation)
  end

  def show
    calculation = Api::V1::Calculation.find(params[:id], @current_user)
    render json: Api::V1::Serializers::CalculationSerializer.new(calculation)
  end

  private

  def create_params
    params.require(:calculation).permit(:calculator_id, input: {})
  end
end
