class CreateFirstCalculator < ActiveRecord::Migration[7.0]
  def change
    clcr = Api::V1::CalculationTopic.create!(
      name: 'Declaración de la Renta',
      description: 'Obtén un presupuesto inmediato para la confección de tu declaración de la renta',
      validation_file: 'declaracion_renta.json',
      prediction_attributes: {
        'alquileres' => {
          'name' => 'alquileres',
          'type' => 'integer',
          'var_type' => 'continuous',
          'question' => {
            'title' => '¿Tienes alquileres o hipotecas?',
            'field_type' => 'input',
          },
        },
        'duenio_inmueble_arrendado': {
          'name' => 'duenio_inmueble_arrendado',
          'type' => 'integer',
          'var_type' => 'continuous',
          'question' => {
            'title' => '¿Eres dueño de un inmueble arrendado?',
            'field_type' => 'input',
          },
        },
        'actividad_economica': {
          'name' => 'actividad_economica',
          'type' => 'boolean',
          'var_type' => 'discrete',
          'question' => {
            'title' => '¿Tienes actividad empresarial o profesional?',
            'field_type' => 'boolean',
          },
        },
        'pareja_matrimonio': {
          'name' => 'pareja_matrimonio',
          'type' => 'boolean',
          'var_type' => 'discrete',
          'question' => {
            'title' => '¿Vas a realizar la declaración de la renta con tu pareja?',
            'field_type' => 'boolean',
          },
        },
        'cambio_vivienda_habitual': {
          'name' => 'cambio_vivienda_habitual',
          'type' => 'boolean',
          'var_type' => 'discrete',
          'question' => {
            'title' => '¿Has cambiado de vivienda habitual?',
            'field_type' => 'boolean',
          },
        },
        'operacion_acciones': {
          'name' => 'operacion_acciones',
          'type' => 'integer',
          'var_type' => 'continuous',
          'question' => {
            'title' => '¿Has realizado operaciones con acciones?',
            'field_type' => 'input',
          },
        },
        'compra_venta_vivienda': {
          'name' => 'compra_venta_vivienda',
          'type' => 'integer',
          'var_type' => 'continuous',
          'question' => {
            'title' => '¿Has comprado o vendido un inmueble que no sea tu vivienda habitual?',
            'field_type' => 'input',
          },
        },
        'pensiones_epsv': {
          'name' => 'pensiones_epsv',
          'type' => 'boolean',
          'var_type' => 'discrete',
          'question' => {
            'title' => '¿Has rescatado un plan de pensiones o EPSV?',
            'field_type' => 'boolean',
          },
        },
        'minusvalia': {
          'name' => 'minusvalia',
          'type' => 'boolean',
          'var_type' => 'discrete',
          'question' => {
            'title' => '¿Tienes reconocida una minusvalía?',
            'field_type' => 'boolean',
          },
        },
        'despido': {
          'name' => 'despido',
          'type' => 'boolean',
          'var_type' => 'discrete',
          'question' => {
            'title' => '¿Has sido despedido?',
            'field_type' => 'boolean',
          },
        },
        'familia_numerosa': {
          'name' => 'familia_numerosa',
          'type' => 'boolean',
          'var_type' => 'discrete',
          'question' => {
            'title' => '¿Tienes reconocida la condición de familia numerosa?',
            'field_type' => 'boolean',
          },
        },
      }
    )

    Api::V1::Organization.all.each do |org|
      Api::V1::Calculator.create!(
        calculation_topic: clcr,
        classifications: {
          declaracion0: "65",
          declaracion1: "80",
          declaracion2: "100",
          declaracion3: "120",
          declaracion4: "150",
          declaracion5: "200",
          declaracion6: "250",
        },
        version: 0,
        marshalled_predictor: 'a',
        organization: org,
        calculator_status: :disabled
      )
    end
  end
end
