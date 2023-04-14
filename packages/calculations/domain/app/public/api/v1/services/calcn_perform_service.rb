class Api::V1::Services::CalcnPerformService < ApplicationService
  def call(_current_account, _calculator_id, _input)
    calculator = calculation.calculator
    calculator.perform(calculation)
  end
end
