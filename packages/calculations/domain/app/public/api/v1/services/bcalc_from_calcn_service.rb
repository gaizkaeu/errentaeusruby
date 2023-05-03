module Api
  module V1
    module Services
      class BcalcFromCalcnService < ApplicationService
        include Pagy::Backend

        def call(calcn, _page = 1)
          @calcn = calcn
          ctopic_id = calcn.calculation_topic_id

          return calcn.bulk_calculation unless calcn.bulk_calculation_id.nil?

          create_bulk_from_calcn

          # Calculators

          calculators = Calculator.where(calculation_topic_id: ctopic_id)
                                  .where.not(id: calcn.calculator_id)
                                  .where(calculator_status: :live)

          calculators.map do |calculator|
            run_calculation(calculator)
          end
        end

        def run_calculation(calculator)
          clcn = Calculation.create!(
            input: @bcalc.input,
            user: @bcalc.user,
            calculation_topic: @bcalc.calculation_topic,
            calculator:,
            bulk_calculation: @bcalc
          )

          @bcalc.calculations << clcn

          clcn
        end

        def create_bulk_from_calcn
          # Create bulk calculation
          @bcalc = BulkCalculation.new(
            input: @calcn.input,
            user: @calcn.user,
            calculation_topic: @calcn.calculation_topic
          )

          @bcalc.save!

          # Update calcn
          @calcn.bulk_calculation = @bcalc
          @calcn.save!
        end
      end
    end
  end
end
