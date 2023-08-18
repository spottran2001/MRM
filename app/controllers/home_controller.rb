class HomeController < ApplicationController
  def index
  end

  def home_page
  end

  def page_usinfo
    @user = User.find(params[:user])
  end
end
