class Api::V1::PushController < ApiBaseController
  require 'json'
  # rubocop:disable Metrics/AbcSize
  def send_push
    Webpush.payload_send(
      message: { title: 'Hola', url: 'https://errenta.eus/llego' }.to_json,
      endpoint: params['subscription']['endpoint'],
      p256dh: params['subscription']['keys']['p256dh'],
      auth: params['subscription']['keys']['auth'],
      vapid: {
        subject: 'mailto:sender@example.com',
        public_key: Rails.application.config.x.vapid_public,
        private_key: Rails.application.config.x.vapid_private
      },
      ssl_timeout: 5, # value for Net::HTTP#ssl_timeout=, optional
      open_timeout: 5, # value for Net::HTTP#open_timeout=, optional
      read_timeout: 5 # value for Net::HTTP#read_timeout=, optional
    )
  end
  # rubocop:enable Metrics/AbcSize
end
