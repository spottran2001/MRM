class AcademicController < ApplicationController
  before_action :authenticate_user!
  before_action :current_report, only: [:report_details, :accept_report, :review_report, :reject_report]
  add_breadcrumb "QUẢN LÝ KỲ BÁO CÁO", :academic_index_path
  def index
    @academic = Academic.all.order(:created_at)
  end

  def show 
    @academic = Academic.find(params[:id])
    add_breadcrumb "CHI TIẾT KỲ BÁO CÁO", :academic_path
  end

  def report_list
    @academic = Academic.find(params[:id])
    @report_list = Report.where(academic_id: params[:id])
    add_breadcrumb "CHI TIẾT KỲ BÁO CÁO", :academic_path
    add_breadcrumb "DANH SÁCH BÁO CÁO CHI TIẾT", :report_list_academic_path
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
    @file_count = @report_template.file_count.present? ? JSON.parse(@report_template.file_count) : []
    add_breadcrumb "CHI TIẾT KỲ BÁO CÁO", :academic_path
    add_breadcrumb "DANH SÁCH BÁO CÁO CHI TIẾT", :report_list_academic_path
    add_breadcrumb "CHI TIẾT BÁO CÁO THÁNG", :review_report_academic_path
  end

  def accept_report
    if @report.report_type&.name_type == 'cho duyet'
      report_type_id = ReportType.find_by(name_type: "da duyet", type_report: "dung han").id
      @report.update(submiter_id: current_user.id, report_type_id: report_type_id, confirm_time: Time.current, feedback: params[:report] ? params[:report][:feedback] : "")
      @report.user.notifications.create(content: "Báo cáo của bạn đã được duyệt")
    end
    redirect_to report_list_academic_path(@academic, status: @report.role)
  end

  def reject_report
    if @report.report_type&.name_type == 'cho duyet'
      report_type_id = ReportType.find_by(name_type: "can bo sung", type_report: "dang bao cao").id
      @report.update(returner_id: current_user.id, report_type_id: report_type_id, return_time: Time.current, feedback: params[:report] ? params[:report][:feedback] : "")
      @report.user.notifications.create(content: "Báo cáo của bạn vừa bị từ chối")
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
