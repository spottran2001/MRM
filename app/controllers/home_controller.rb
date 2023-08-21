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

  def report

  end

  def edit
    @user = User.find(params[:id])
    @role = Role.all
    @faculties = Faculty.all
    @subjects = Subject.all
  end
end
