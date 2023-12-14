class SubjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    add_breadcrumb "QUẢN LÝ BỘ MÔN", :subjects_path
    @subject = Subject.new
    @pagy, @subjects = pagy(Subject.all, items: 8)
  end

  def create
    @subject = Subject.create(create_subject_params)
    redirect_to subjects_path
  end

  def update
    @subject.update(name: params[:name])
  end

  def destroy
    if User.where(subject_id: params[:id]).present? || ReportTemplate.where(subject_id: params[:id]).present?
      raise 'You can not delete this subject because it has been used already'
    end
    @subject.destroy!
  end

  private
  def create_subject_params
    params.require(:subject).permit(:name, :faculty_id)
  end
end
