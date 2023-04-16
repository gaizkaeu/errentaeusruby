CalculatorPubSub = PubSubManager.new

CalculatorPubSub.register_event('calculator.perform_calculation') do
  calculation_id String
end

CalculatorPubSub.subscribe('calculator.perform_calculation', CalculationJob)
