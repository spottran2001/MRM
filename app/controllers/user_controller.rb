class UserController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.role != "admin"
      @user = User.find(current_user.id)
    else
      @user = User.all
    end
  end

  def page_login
  end

  def show
    @user = params[:id].blank? ? User.find(current_user.id) : User.find(params[:id])
  end

  def page_stats
  end

  def report

  end

  def edit
    @user = User.find(params[:id])
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
end
