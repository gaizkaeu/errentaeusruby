class AddSomeTestData < ActiveRecord::Migration[7.0]
  def change
    topic = Api::V1::CalculationTopic.create(
      name: 'Declaración de la renta',
      description: 'Calcula tu declaración de la renta',
      prediction_attributes: {
        cambio_de_vivienda: {
          name: "cambio_de_vivienda",
          type: "integer",
          question: {
            text: "¿Has cambiado de vivienda en el último año?",
            field_type: "input",
          },
          var_type: "continuous",
        }
      },
      colors: "bg-gradient-to-r from-pink-500 via-red-500 to-yellow-500 text-white"
    )

    Api::V1::Organization.all.each do |org|
      Api::V1::Calculator.create(
        calculation_topic: topic,
        organization: org,
        marshalled_predictor: Marshal.dump('a')
      )
    end
  end
end
