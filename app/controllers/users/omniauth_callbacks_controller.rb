class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    @user = User.from_spotify(request.env['omniauth.auth'])
    remember_and_redirect
  end

  private

  def remember_and_redirect
    @user.remember_me!
    sign_in_and_redirect @user
  end
end
