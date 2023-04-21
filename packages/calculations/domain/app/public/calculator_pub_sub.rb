CalculatorPubSub = PubSubManager.new

CalculatorPubSub.register_event('calculator.perform_calculation') do
  calculation_id String
end

CalculatorPubSub.register_event('calculator.train') do
  calculator_id String
end

CalculatorPubSub.subscribe('calculator.perform_calculation', CalcrPredictJob)
CalculatorPubSub.subscribe('calculator.train', CalcrTrainJob)
