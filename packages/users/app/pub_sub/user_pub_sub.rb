UserPubSub = PubSubManager.new
UserPubSub.register_event('user.logged_in') do
  user_id Integer
  ip String
end

UserPubSub.subscribe('user.logged_in', LogAccountLoginJob)
