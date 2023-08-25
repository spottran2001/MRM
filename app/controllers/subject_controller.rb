class SubjectController < ApplicationController
  before_action :authenticate_user!

  def index
    @subjects = Subject.where(user_id: current_user.id).order(:created_at)
  end

  def create
    @subject = Subject.create(create_subject_params)
  end

  def update
    @subject.update(name: params[:name])
  end

  def destroy
    if User.where(subject_id: @subject.id).present? || ReportTemplate.where(subject_id: @subject.id).present?
      raise 'You can not delete this subject because it has been used already'
    end
    @subject.destroy!
  end

  private
  def create_subject_params
    params.require(:subject).permit(:name, :uid)
  end
end
