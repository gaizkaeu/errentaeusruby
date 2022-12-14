Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.env.production? ? 'https://errenta.eus' : 'http://localhost:5173'
    resource '*', headers: :any, methods: %i[get post patch put], credentials: true
  end
end
