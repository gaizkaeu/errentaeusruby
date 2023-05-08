class RodauthApp < Rodauth::Rails::App
  # primary configuration
  configure RodauthMain

  # secondary configuration
  # configure RodauthAdmin, :admin
  route do |r|
    rodauth.load_memory # autologin remembered users

    r.rodauth # route rodauth requests
  end
end
