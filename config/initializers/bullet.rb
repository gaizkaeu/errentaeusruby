if Rails.env.development? || Rails.env.test?
  Bullet.add_safelist type: :unused_eager_loading, class_name: 'Api::V1::Calculation', association: :calculation_topic
end
