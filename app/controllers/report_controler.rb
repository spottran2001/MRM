class ReportController < ApplicationController
  before_action :authenticate_user!

  def index
    @report = Report.where(user_id: current_user.id).order(:created_at)
  end

  def update
    #just admin can do this
    @report_template = ReportTemplate.find(params[:report_template_id])
    
    template_keys = JSON.parse(@report_template.title).keys

    @report = @report_template.report.create!(
      template_keys: template_keys,
      
    )
  end

  private

  def current_report
    @current_report = Report.where(user_id: current_user.id).find(params[:id])
  end
end
