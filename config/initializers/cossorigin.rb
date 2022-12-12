Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://errenta.eus'
    resource '*', headers: :any, methods: %i[get post patch put], credentials: true
    
  end
end
