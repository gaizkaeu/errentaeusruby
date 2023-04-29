class ChangePredictionAttributes < ActiveRecord::Migration[7.0]
  def change
    ctopic = Api::V1::CalculationTopic.first!

    ctopic.prediction_attributes['despido'] = {
      'name' => 'despido',
      'type' => 'boolean',
      'question' => {
        'title' => '¿Ha cambiado tu situación laboral?',
        'field_type' => 'boolean',
      },
      'var_type' => 'discrete',
    }

    ctopic.prediction_attributes['estado_civil'] = {
      'name' => 'estado_civil',
      'type' => 'boolean',
      'question' => {
        'title' => '¿Ha cambiado tu estado civil?',
        'field_type' => 'boolean',
      },
      'var_type' => 'discrete',
    }

    ctopic.prediction_attributes['primera_vez'] = {
      'name' => 'primera_vez',
      'type' => 'boolean',
      'question' => {
        'title' => '¿Es la primera vez que presentas la declaración de la renta?',
        'field_type' => 'boolean',
      },
      'var_type' => 'discrete',
    }


    ctopic.save!
  end
end
