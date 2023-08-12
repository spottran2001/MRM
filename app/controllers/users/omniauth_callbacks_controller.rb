class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def azure_activedirectory_v2
    @request_info = request.env['omniauth.auth']
    if @request_info.blank?
      redirect_to :root
    else
      @user = User.find_by(email: @request_info.info.email)
      if @user.blank?
        @user = User.create!(email: @request_info.info.email, password: @request_info.uid, subject_id: 1, faculty_id: 1, reset_password_token: @request_info.uid, name: @request_info.info.name)
      end
      return redirect_to page_usinfo_path(user: @user)
    end
  end
end