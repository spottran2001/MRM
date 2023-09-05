class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role != "admin"
      @users = User.where(id: current_user.id)
    else
      @users = User.all
    end

    ReportTemplate.create!(id: 1,
      apply_time: nil,
      is_apply: nil,
      title:
       "{\"title1\":{\"key1\":[\"123,3123123,5,4,312,3,2\",\"1,khoates123,text,text,text,text,text\"]},\"title2\":{\"key21\":[\"123,123,32,3,2,1,2\",\"1,khoates123,text,text,text,text,text\"],\"key22\":[\"322,123123,123,2,1,3,2\",\"1,khoates123,text,text,text,text,text\"]},\"title3\":{\"key31\":[\"some,2,3,1,2,3,4\",\"1,khoates123,text,text,text,text,text\",\"1,text,text,text,text,text,text\",\"1,text,text,text,text,text,text\"]}}",
      uid: nil,
      academic_year_id: nil,
      subject_id: nil,
      deadline: nil)
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
    if current_user.role != 'admin'
      @user.update!(update_phone_params)
    else
      @user.update!(update_phone_params) #add this column to database!
    end
    redirect_to users_path
  end

  def generate_report
    raise "you dont have permission to do this " if current_user.role != 'admin'
  end

  def update_phone_params
    params.require(:user).permit(:phone_number)
  end

  def read_notification
    current_user.read_notification!
  end
end
