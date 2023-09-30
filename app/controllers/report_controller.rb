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
    report.update!(data: JSON.generate(report_data))
    #redirect_to :controller => 'report', :action => 'show', :param => {id: report.id}
  end


  def show
    @report_template_title = JSON.parse(Report.find(params[:id]).data)
    @report_template = Report.find(params[:id])
  end

  def edit
    @report_template_title = JSON.parse(Report.find(params[:id]).data)
    @report_template = Report.find(params[:id])
  end

  #baocaonhanvien
  def new

  end

  #quanlikibaocaostaff
  def index
  end

end