module AuthHelpers
  def set_session(vars = {})
    post test_session_path, params: { session_vars: vars }
    expect(response).to have_http_status(:created)

    vars.each_key do |var|
      expect(session[var]).to be_present
    end
  end

  def sign_in(user)
    set_session(account_id: user.account.id)
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
