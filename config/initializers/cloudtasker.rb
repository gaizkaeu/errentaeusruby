Cloudtasker.configure do |config|
    #
    # Adapt the server port to be the one used by your Rails web process
    #
    config.processor_host = Rails.env.production? ? ENV.fetch('APP_HOST', "https://errenta.eus") : "http://localhost:3000"
  
    #
    # If you do not have any Rails secret_key_base defined, uncomment the following
    # This secret is used to authenticate jobs sent to the processing endpoint
    # of your application.
    #
    config.secret = ENV.fetch('SECRET_KEY_BASE', "dummy")

    config.gcp_queue_prefix = ENV.fetch('QUEUE_PREFIX', "errenta")

    config.gcp_location_id = ENV.fetch('LOCATION', "europe-west1")
    config.gcp_project_id = ENV.fetch('PROJECT_ID', "eliza-asesores")
  end if Rails.env.production?