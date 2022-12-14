module AuthHelpers
  def sign_in(user)
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload:)
    @tokens = session.login
    @authorized_headers = { Authorization: "Bearer #{@tokens[:access]}" }
  end

  def authorized_get(*args, **kwargs)
    kwargs[:headers] = @authorized_headers
    get(*args, **kwargs)
  end

  def authorized_post(*args, **kwargs)
    kwargs[:headers] = @authorized_headers
    post(*args, **kwargs)
  end

  def authorized_put(*args, **kwargs)
    kwargs[:headers] = @authorized_headers
    put(*args, **kwargs)
  end

  def authorized_patch(*args, **kwargs)
    kwargs[:headers] = @authorized_headers
    put(*args, **kwargs)
  end

  def authorized_delete(*args, **kwargs)
    kwargs[:headers] = @authorized_headers
    delete(*args, **kwargs)
  end
end
