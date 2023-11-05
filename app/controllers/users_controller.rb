class UsersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    if current_user.role != "admin"
      @users = User.where(id: current_user.id)
    else
      users = User.all
      @pagy, @users = pagy(users.all, items: 8)
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
    @is_admin = current_user.role.include?('admin')
  end

  def update
    @user = User.find(params[:id])
    role = params['role'].split(',')
    if params["current_user_role"].include?('admin')
      @user.update!(role: role.join(','), phone_number: params['phoneNumber'], faculty_id: params['faculty'] ,subject_id: params['subject'] )
    else
      @user.update!(phone_number: params['phoneNumber']) #add this column to database!
    end
  end

  def generate_report
    raise "you dont have permission to do this " if current_user.role != 'admin'
  end

  def read_notification
    current_user.read_notification!
  end
end
