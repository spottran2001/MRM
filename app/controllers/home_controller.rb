class HomeController < ApplicationController
  def index
  end

  def page_login
  end

  def page_usinfo
    @user = User.find(params[:user])
  end

  def page_stats
  end
end
