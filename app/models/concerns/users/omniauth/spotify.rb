module Users
  module Omniauth
    module Spotify
      def from_spotify(auth)
        binding.pry
        email = email_from_auth(auth)
        base_attributes = {
          spotify_name: auth.info.name,
          spotify_token: auth.credentials.token,
          spotify_refresh_token: auth.credentials.refresh_token,
          spotify_id: auth.extra.raw_info.id
        }
        if user = find_by(email:)
          user.update(**base_attributes)
          user
        else
          create(
            email:,
            password: Devise.friendly_token[0, 20],
            **base_attributes
          )
        end
      end

      def email_from_auth(auth)
        auth.info.email || auth.extra.raw_info.email
      end
    end
  end
end
