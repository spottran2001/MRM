class FacultyController < ApplicationController
  before_action :authenticate_user!

  def index
    @faculties = Faculty.all.order(:created_at)
    users = User.all
      @pagy, @users = pagy(users.all, items: 8)
  end

  def create
    @faculty = Faculty.create(create_faculty_params)
  end

  def update
    @faculty.update(name: params[:name])
  end

  def destroy
    if User.where(faculty_id: params[:id]).present?
      raise 'You can not delete this faculty because it has been used already'
    end
    @faculty.destroy!
  end

  private

  def create_faculty_params
    params.require(:faculty).permit(:name, :uid)
  end
end
