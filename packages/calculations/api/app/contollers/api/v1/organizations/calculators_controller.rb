# frozen_string_literal: true

class Api::V1::Organizations::CalculatorsController < ApplicationController
  def index
    calc = Api::V1::Calculator.where(organization_id: params[:organization_id]).includes([:calculation_topic])

    render json: Api::V1::Serializers::CalculatorSerializer.new(calc)
  end

  def show
    calc = Api::V1::Calculator.find_by(id: params[:id], organization_id: params[:organization_id])

    render json: Api::V1::Serializers::CalculatorSerializer.new(calc)
  end
end
