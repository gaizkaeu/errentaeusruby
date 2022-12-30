# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Errentaeusreact
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.api_only = true

    config.session_store :cookie_store, key: '_your_app_api_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options

    config.autoload_paths << Rails.root.join('app', 'services')
    config.paths.add 'packages', glob: '*/app/{*,*/concerns}', eager_load: true

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.action_mailer.default_url_options = { host: ENV.fetch('FRONTEND_APP_HOST', 'errenta.eus') }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV.fetch('SMTP_HOST', nil),
      port: ENV.fetch('SMTP_PORT', 465),
      domain: ENV.fetch('SMTP_DOMAIN', 'errenta.eus'),
      user_name: ENV.fetch('SMTP_USERNAME', 'asds@gmail.com'),
      password: ENV.fetch('SMTP_PASSWORD', 'notgoingtogetthishahha'),
      authentication: 'plain',
      enable_starttls_auto: true,
      ssl: true,
      tls: true,
      open_timeout: 5,
      read_timeout: 5
    }

    config.x.estimation_sign_key = ENV.fetch('ESTIMATIONS_SIGN_SECRET', 'dummy_password')

    config.x.vapid_public = ENV.fetch('VAPID_PUBLIC', 'dummy_key')
    config.x.vapid_private = ENV.fetch('VAPID_PRIVATE', 'dummy_key')

    config.x.domain_cookies = ENV.fetch('APP_DOMAIN_COOKIES', '.errenta.eus')
    config.x.frontend_app = ENV.fetch('FRONTEND_APP_HOST', 'errenta.eus')

    config.middleware.use Rack::Deflater
  end
end
