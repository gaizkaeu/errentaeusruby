json.partial! 'api/v1/users/user', user: @user
json.csrf @tokens[:csrf]
