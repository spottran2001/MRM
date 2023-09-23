class HomeController < ApplicationController
  before_action :authenticate_user!

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

  def update
    @user = User.find(params[:id])
    if @current_user.role != 'admin'
      user.update!(params)
    else
      user.update!(params[:phone_number]) #add this column to database!
    end
  end

  def staff
  end

  def generalReportForm
  end

end
