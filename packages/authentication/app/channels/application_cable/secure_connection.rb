module ApplicationCable
  class Connection < Channels::ApplicationCable::Connection
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if rodauth.authenticated?
        rodauth.rails_account
      else
        reject_unauthorized_connection
      end
    end

    def rodauth
      @rodauth ||= RodauthApp.new(env).rodauth
    end
  end
end
