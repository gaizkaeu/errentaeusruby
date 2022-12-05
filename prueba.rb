require "webpush"

vapid_key = Webpush.generate_key

# Save these in your application server settings
puts vapid_key.public_key
puts "priv"
puts vapid_key.private_key