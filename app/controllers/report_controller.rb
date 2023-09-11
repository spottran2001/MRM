class ReportController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def submit_report!
    report_value = {}
    title_keys = JSON.parse(params["title_2_title_arr"])
    td_value_arr = JSON.parse(params["content__table_body_td_value_arr"])
    title_keys.each_with_index do |key, index|
      report_value["#{key}".to_sym] = td_value_arr[index]
    end
    report_template = ReportTemplate.find(params[:report_id])
    report_title = JSON.parse(report_template.title).each do |key, value|
      value.each do |k, v|
        if report_value[k.to_sym].present?
          value[k] = report_value[k.to_sym]
        end
      end
    end
    report_template.update!(title: JSON.generate(report_title))
  end


  #baocaonhanvien
  def new

  end

  #quanlikibaocaostaff
  def index
  end
end