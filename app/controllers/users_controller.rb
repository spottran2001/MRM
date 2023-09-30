class UsersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    if current_user.role != "admin"
      @users = User.where(id: current_user.id)
    else
      @users = User.all
    end
  end

  def page_login
  end

  def show
    @user = params[:id].blank? ? User.find(current_user.id) : User.find(params[:id])
  end

  def page_stats
  end

  def report_templates
    report_templates = ReportTemplate.all.order(:created_at)
  end

  def edit
    @user = User.find(params[:id])
    @faculties = Faculty.all
    @subjects = Subject.all
  end

  def update
    @user = User.find(params[:id])
    params['user']['role'].drop(1)
    if current_user.role == 'admin'
      @user.update!(role: params['user']['role'].join(','), phone_number: params['user']['phone_number'])
    else
      @user.update!(phone_number: params['user']['phone_number']) #add this column to database!
    end
    redirect_to users_path
  end

  def generate_report
    raise "you dont have permission to do this " if current_user.role != 'admin'
  end

  def read_notification
    current_user.read_notification!
  end
end
