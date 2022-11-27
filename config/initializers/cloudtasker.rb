Cloudtasker.configure do |config|
    #
    # Adapt the server port to be the one used by your Rails web process
    #
    config.processor_host = Rails.env.production? ? "https://errenta.eus" : "http://localhost:3000"
  
    #
    # If you do not have any Rails secret_key_base defined, uncomment the following
    # This secret is used to authenticate jobs sent to the processing endpoint
    # of your application.
    #
    # config.secret = 'some-long-token'
  end