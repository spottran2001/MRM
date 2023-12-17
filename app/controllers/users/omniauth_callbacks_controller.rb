class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def azure_activedirectory_v2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    UserMailer.welcome_email(@user).deliver_now
    sign_in_and_redirect @user
  end

  def sign_out
    sign_out_and_redirect root
  end
end