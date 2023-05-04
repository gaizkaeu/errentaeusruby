class ChangeInput < ActiveRecord::Migration[7.0]
  def change
    Api::V1::CalculationTopic.first.update!(
      prediction_attributes: {
    "despido"=>{"name"=>"despido", "type"=>"boolean", "question"=>{"title"=>"¿Ha cambiado tu situación laboral?", "field_type"=>"boolean"}, "var_type"=>"discrete"},
   "alquileres"=>{"name"=>"alquileres", "type"=>"integer", "question"=>{"title"=>"¿Tienes alquileres o hipotecas?", "field_type"=>"input_with_defaults","label": "Alquileres/Hipotecas", "options"=>[{"key"=>"No", "value"=>"0"}, {"key"=>"Una hipoteca/alquiler", "value"=>"1"}, {"key"=>"Dos hipotecas/alquileres", "value"=>"2"}, {"key"=>"Tres hipotecas/alquileres", "value"=>"3"}]}, "var_type"=>"continuous"},
   "minusvalia"=>{"name"=>"minusvalia", "type"=>"boolean", "question"=>{"title"=>"¿Tienes reconocida una minusvalía?", "field_type"=>"boolean"}, "var_type"=>"discrete"},
   "primera_vez"=>{"name"=>"primera_vez", "type"=>"boolean", "question"=>{"title"=>"¿Es la primera vez que presentas la declaración de la renta?", "field_type"=>"boolean"}, "var_type"=>"discrete"},
   "estado_civil"=>{"name"=>"estado_civil", "type"=>"boolean", "question"=>{"title"=>"¿Ha cambiado tu estado civil?", "field_type"=>"boolean"}, "var_type"=>"discrete"},
   "pensiones_epsv"=>{"name"=>"pensiones_epsv", "type"=>"boolean", "question"=>{"title"=>"¿Has rescatado un plan de pensiones o EPSV?", "field_type"=>"boolean"}, "var_type"=>"discrete"},
   "familia_numerosa"=>{"name"=>"familia_numerosa", "type"=>"boolean", "question"=>{"title"=>"¿Tienes reconocida la condición de familia numerosa?", "field_type"=>"boolean"}, "var_type"=>"discrete"},
   "pareja_matrimonio"=> {"name"=>"pareja_matrimonio", "type"=>"boolean", "question"=>{"title"=>"¿Vas a realizar la declaración de la renta con tu pareja?", "field_type"=>"boolean"}, "var_type"=>"discrete"},
   "operacion_acciones"=>{"name"=>"operacion_acciones", "type"=>"integer", "question"=>{"title"=>"¿Has realizado operaciones con acciones?", "label": "Operaciones acciones", "field_type"=>"input_with_defaults", "options"=>[{"key"=>"No", "value"=>"0"}, {"key"=>"Una operacion", "value"=>"1"}, {"key"=>"Dos operaciones", "value"=>"2"}, {"key"=>"Tres operaciones", "value"=>"3"}]}, "var_type"=>"continuous"},
   "actividad_economica"=>{"name"=>"actividad_economica", "type"=>"boolean", "question"=>{"title"=>"¿Tienes actividad empresarial o profesional?", "field_type"=>"boolean"}, "var_type"=>"discrete"},
   "compra_venta_vivienda"=>
    {"name"=>"compra_venta_vivienda",
     "type"=>"integer",
     "question"=>
      {"label"=>"Compraventa vivienda(s)",
       "title"=>"¿Has comprado o vendido un inmueble que no sea tu vivienda habitual?",
       "options"=>[{"key"=>"No", "value"=>"0"}, {"key"=>"Una compraventa", "value"=>"1"}, {"key"=>"Dos compraventas", "value"=>"2"}, {"key"=>"Tres compraventas", "value"=>"3"}],
       "field_type"=>"input_with_defaults"},
     "var_type"=>"continuous"},
   "cambio_vivienda_habitual"=> {"name"=>"cambio_vivienda_habitual", "type"=>"boolean", "question"=>{"title"=>"¿Has cambiado de vivienda habitual?", "field_type"=>"boolean"}, "var_type"=>"discrete"},
   "duenio_inmueble_arrendado"=> {"name"=>"duenio_inmueble_arrendado", "type"=>"integer", "question"=>{"title"=>"¿Eres dueño de un inmueble arrendado?", "label": "Inmuebles arrendados", "field_type"=>"input_with_defaults", "options"=>[{"key"=>"No", "value"=>"0"}, {"key"=>"Una inmueble arrendado", "value"=>"1"}, {"key"=>"Dos inmuebles arrendados", "value"=>"2"}, {"key"=>"Tres inmuebles arrendados", "value"=>"3"}]}, "var_type"=>"continuous"}}
    )
  end
end
