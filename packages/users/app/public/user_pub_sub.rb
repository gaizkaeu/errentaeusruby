UserPubSub = PubSubManager.new

UserPubSub.register_event('user.created') do
  user_id String
  ip String
  provider String
  time String
  action 5
end

UserPubSub.register_event('user.logged_in') do
  user_id String
  ip String
  provider String
  time String
  action 0
end

UserPubSub.register_event('user.refresh_token') do
  user_id String
  ip String
  time String
  action 1
end

UserPubSub.register_event('user.logout') do
  user_id String
  ip String
  time String
  action 2
end

UserPubSub.register_event('user.blocked') do
  user_id String
  time String
  action 3
end

UserPubSub.register_event('user.updated') do
  user_id String
  time String
  action 4
end

UserPubSub.subscribe('user.logged_in', LogAccountLoginJob)
UserPubSub.subscribe('user.created', LogAccountLoginJob)
UserPubSub.subscribe('user.created', CreationUserJob)
UserPubSub.subscribe('user.refresh_token', LogAccountLoginJob)
UserPubSub.subscribe('user.logout', LogAccountLoginJob)
UserPubSub.subscribe('user.blocked', LogAccountLoginJob)
UserPubSub.subscribe('user.updated', LogAccountLoginJob)
