class FacultiesController < ApplicationController
  before_action :authenticate_user!

  def index
    add_breadcrumb "QUẢN LÝ KHOA", :faculties_path
    @faculty = Faculty.new
    faculties = Faculty.all
    if params[:filter].present?
      faculties = faculties.where("name like ?", "%#{params[:filter]}%")
    end
    @pagy, @faculties = pagy(faculties, items: 8)
  end

  def create
    @faculty = Faculty.create(create_faculty_params)
    redirect_to faculties_path
  end

  def update
    @faculty = Faculty.find(params[:id])
    @faculty.update(name: params[:name])
  end

  def destroy
    if User.where(faculty_id: params[:id]).present?
      # raise 'You can not delete this faculty because it has been used already'
    else
      Faculty.find(params[:id]).destroy!
    end
  end

  private

  def create_faculty_params
    params.require(:faculty).permit(:name)
  end
end
