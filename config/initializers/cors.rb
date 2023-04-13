Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.env.production? ? [%r{https://(.*?)\.errenta\.eus}, 'https://errenta.eus'] : 'http://192.168.1.128:5173'
    resource '*', headers: :any, methods: %i[get post patch put delete], credentials: true
  end
end
