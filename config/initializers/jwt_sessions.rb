JWTSessions.encryption_key = ENV.fetch('JWT_ENCRYPTION_KEY', 'dummy')

JWTSessions.access_cookie = ENV.fetch('JWT_SESSION_COOKIE_NAME', '_errenta_auth')

JWTSessions.token_store = :memory
