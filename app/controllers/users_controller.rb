class UsersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    if current_user.role != "admin"
      users = User.where(id: current_user.id)
      @pagy, @users = pagy(users.all, items: 8)
    else
      users = User.where("email LIKE ? OR role LIKE ?", "%#{params[:filter]}%","%#{params[:filter]}%").all
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
      @user.role =  role.join(',') if role.present?
      @user.phone_number =  params['phoneNumber']
      @user.faculty_id =  params['faculty']
      @user.subject_id =  params['subject'] 
      if params[:avatar].present?
        @user.avatar = params[:avatar]
      end
      @user.save!
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
