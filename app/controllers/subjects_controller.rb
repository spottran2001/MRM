class SubjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    add_breadcrumb "QUẢN LÝ BỘ MÔN", :subjects_path
    @subject = Subject.new
    subject = Subject.joins(:faculty)
    if params[:filter]
      subject = subject.where("subjects.name like ? or faculties.name like ?", "%#{params[:filter]}%", "%#{params[:filter]}%")
    end
    @pagy, @subjects = pagy(subject, items: 8)
  end

  def create
    @subject = Subject.create(create_subject_params)
    redirect_to subjects_path
  end

  def update
    @subject = Subject.find(params[:id])
    @subject.update(name: params[:name], faculty_id: params[:fac_id])
  end

  def destroy
    binding.pry
    if User.where(subject_id: params[:id]).present? || ReportTemplate.where(subject_id: params[:id]).present?
      # raise 'You can not delete this subject because it has been used already'
    else
      @subject = Subject.find(params[:id])
      @subject.destroy!
    end
  end

  private
  def create_subject_params
    params.require(:subject).permit(:name, :faculty_id)
  end
end
