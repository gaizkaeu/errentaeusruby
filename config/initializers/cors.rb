Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.env.production? ? [%r{https://(.*?)\.errenta\.eus}, 'https://errenta.eus'] : 'http://172.20.10.3:5173'
    resource '*', headers: :any, methods: %i[get post patch put delete], credentials: true
  end
end
