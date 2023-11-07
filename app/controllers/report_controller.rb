class ReportController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def submit_report!
    report_value = {}
    title_keys = JSON.parse(params["title_2_title_arr"])
    td_value_arr = JSON.parse(params["content__table_body_td_value_arr"])
    sum_td = JSON.parse(params["sum_td"])
    report = Report.find(params["report_id"])
    report_data = JSON.parse(report.data)
    report_data.keys.each_with_index do |key, index|
      report_data[key].keys.each_with_index do |k, i|
        report_data[key][k]["content"] = []
        sum_td[index][i].each do |td|
          report_data[key][k]["content"] << td
        end
      end
    end
    report_type_id = ReportType.find_by(name_type: "luu nhap", type_report: "chua bao cao").id
    report.update!(data: JSON.generate(report_data), status: 'Luu nhap',report_type_id: report_type_id)
  end

  def save_draft
    report_value = {}
    title_keys = JSON.parse(params["title_2_title_arr"])
    td_value_arr = JSON.parse(params["content__table_body_td_value_arr"])
    sum_td = JSON.parse(params["sum_td"])
    report_data = JSON.parse(report.data)
    report_data.keys.each_with_index do |key, index|
      report_data[key].keys.each_with_index do |k, i|
        report_data[key][k]["content"] = []
        sum_td[index][i].each do |td|
          report_data[key][k]["content"] << td
        end
      end
    end
    report = Report.find(params["report_id"])
    report_type_id = ReportType.find_by(name_type: "luu nhap", type_report: "chua bao cao").id
    report.update(report_type_id: report_type_id)
  end

  def send_report
    # report_value = {}
    # title_keys = JSON.parse(params["title_2_title_arr"])
    # td_value_arr = JSON.parse(params["content__table_body_td_value_arr"])
    # sum_td = JSON.parse(params["sum_td"])
    # report_data = JSON.parse(report.data)
    # report_data.keys.each_with_index do |key, index|
    #   report_data[key].keys.each_with_index do |k, i|
    #     report_data[key][k]["content"] = []
    #     sum_td[index][i].each do |td|
    #       report_data[key][k]["content"] << td
    #     end
    #   end
    # end
    @report = Report.find(params["report_id"])
    report_type_id = ReportType.find_by(name_type: "cho duyet", type_report: "dang bao cao").id
    @report.report_type_id =  report_type_id  
    @report.first_submit = Date.current if @report.first_submit.blank?
    @report.save
  end

  def return_report
    report = Report.find(params["report_id"])
    report_type_id = ReportType.find_by(name_type: "can bo sung", type_report: "dang bao cao").id
    @report.update(report_type_id: report_type_id)  
  end

  def report_apply
    report = Report.find(params["report_id"])
    if report.last_submit_time > report.report_template.end_date
      report_type_id = ReportType.find_by(name_type: "da duyet", type_report: "tre han").id
      @report.update(report_type_id: report_type_id)
    else 
      report_type_id = ReportType.find_by(name_type: "da duyet", type_report: "dung han").id
      @report.update(report_type_id: report_type_id)
    end
  end

  def show
    @report_template_title = JSON.parse(Report.find(params[:id]).data)
    @report_template = Report.find(params[:id])
  end

  def edit
    @report_template_title = JSON.parse(Report.find(params[:id]).data)
    @report_template = Report.find(params[:id])
    report_type = @report_template.report_type&.name_type
    @can_send_report = (report_type == "can bo sung" || report_type == "luu nhap") ? true :false
  end

  #baocaonhanvien
  def new

  end

  #quanlikibaocaostaff
  def index
    @report = current_user.reports.order(:created_at)
  end

end