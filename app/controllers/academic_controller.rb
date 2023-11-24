class AcademicController < ApplicationController
  before_action :authenticate_user!
  before_action :current_report, only: [:report_details, :accept_report, :review_report, :reject_report]
  def index
    @academic = Academic.all.order(:created_at)
  end

  def show 
    @academic = Academic.find(params[:id])
  end

  def report_list
    @academic = Academic.find(params[:id])
    @report_list = Report.where(academic_id: params[:id])
    if params[:status]
      @report_list = @report_list.where(role: params[:status])
    else
      redirect_to root_path
    end
  end

  def review_report
    @report_template_title = JSON.parse(@report.data)
    @report_template = @report
    @can_accept_reject = @report.report_type&.name_type == 'cho duyet' ? true : false
  end

  def accept_report
    if @report.report_type&.name_type == 'cho duyet'
      report_type_id = ReportType.find_by(name_type: "da duyet", type_report: "dung han").id
      @report.update(submiter_id: current_user.id, report_type_id: report_type_id, confirm_time: Time.current, feedback: params[:report] ? params[:report][:feedback] : "")
    end
    redirect_to report_list_academic_path(@academic, status: @report.role)
  end

  def reject_report
    if @report.report_type&.name_type == 'cho duyet'
      report_type_id = ReportType.find_by(name_type: "can bo sung", type_report: "dang bao cao").id
      @report.update(returner_id: current_user.id, report_type_id: report_type_id, return_time: Time.current, feedback: params[:report] ? params[:report][:feedback] : "")
    end
    redirect_to report_list_academic_path(@academic, status: @report.role)
  end

  private

  def current_report
    @report = Report.find_by(academic_id: params[:id], id: params[:report_id])
    @academic = Academic.find(params[:id])

    # redirect_to root_path unless current_user.role&.include?(@report.role)
  end
end
