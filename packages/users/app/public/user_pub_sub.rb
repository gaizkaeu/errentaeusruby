UserPubSub = PubSubManager.new
UserPubSub.register_event('user.logged_in') do
  user_id Integer
  ip String
  provider String
  action 0
end

UserPubSub.register_event('user.refresh_token') do
  user_id Integer
  ip String
  action 1
end

UserPubSub.register_event('user.logout') do
  user_id Integer
  ip String
  action 2
end

UserPubSub.subscribe('user.logged_in', LogAccountLoginJob)
UserPubSub.subscribe('user.refresh_token', LogAccountLoginJob)
UserPubSub.subscribe('user.logout', LogAccountLoginJob)
