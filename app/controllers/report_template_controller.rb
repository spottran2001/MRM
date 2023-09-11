class ReportTemplateController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
  end

  def new
    @report_template = ReportTemplate.create!(
      title: JSON.generate(params[:title]),
      uid: params[:uid],
      academic_year_id: params[:academic_year_id],
      subject_id: params[:subject_id],
      deadline: params[:deadline]
    )
  end

  def edit
    @report_template
  end

  def update
    @report_template.udpate(update_params)
  end
  
  def show
    @report_template_title = JSON.parse(ReportTemplate.find(params[:id]).title)
    @report_template = ReportTemplate.find(params[:id])
  end

  def apply_temple
    raise "this academic year have teamplate yet" if ReportTemplate.where(academic_year_id: @report_template.academic_year_id, is_apply: true).present?
    @report_template.update(is_apply: true)
  end

  private

  def current_template
    @report_template = ReportTemplate.find(params[:id])
  end
end
