module Users
  module Omniauth
    module Spotify
      def from_spotify(auth)
        email      = email_from_auth(auth)
        attributes = base_attributes(auth)
        build_user(email, attributes)
      end

      private

      def build_user(email, attributes)
        if user = find_by(email:)
          user.update(**attributes)
          user
        else
          create(
            email:,
            password: Devise.friendly_token[0, 20],
            **attributes
          )
        end
      end

      def email_from_auth(auth)
        auth.info.email || auth.extra.raw_info.email
      end

      def base_attributes(auth)
        {
          spotify_name: auth.info.name,
          spotify_token: auth.credentials.token,
          spotify_refresh_token: auth.credentials.refresh_token,
          spotify_id: auth.extra.raw_info.id
        }
      end
    end
  end
end
