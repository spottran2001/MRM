class ReportController < ApplicationController
  require 'csv'
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def submit_report!
    ActiveRecord::Base.transaction do 
      report_value = {}
      title_keys = JSON.parse(params["title_2_title_arr"])
      td_value_arr = JSON.parse(params["content__table_body_td_value_arr"])
      sum_td = JSON.parse(params["sum_td"])
      report = Report.find(params["report_id"])
      report_data = JSON.parse(report.data)

      # save the content of report
      report_data.keys.each_with_index do |key, index|
        report_data[key].keys.each_with_index do |k, i|
          report_data[key][k]["content"] = []
          sum_td[index][i].each do |td|
            report_data[key][k]["content"] << td
          end
        end
      end

      #files [2,3,4,5]
      file_count = report.file_count.present? ? JSON.parse(report.file_count) : []
      file_ids = []
      JSON.parse(params['sum_files']).sum.times do |i|
        file = report.report_attachments.create(attachment: params["file"][i])
        file_ids << file.id
      end
      JSON.parse(params['sum_files']).each_with_index do |number_files, index|
        file_count[index] = [] if file_count[index].blank?
        number_files.times do |n|
          file_count[index] << file_ids.delete_at(0)
        end
      end
      file_count = file_count.to_s
      delete_file_ids = params['delete_file']
      if delete_file_ids.present?
        delete_file_ids = delete_file_ids.split(',')
        delete_file_ids.each do |id|
          if id.present?
            file_count = file_count.gsub(",#{id}", "")
            file_count = file_count.gsub("#{id},", "")
            file_count = file_count.gsub("#{id}", "")
          end
        end
      end
      # params['file'][0..-1].each do |f|
      #   report.report_attachments.create(attachment: f)
      # end
      report_type_id = ReportType.find_by(name_type: "Lưu nháp", type_report: "Chưa báo cáo").id
      report.update!(data: JSON.generate(report_data), status: 'Lưu nháp',report_type_id: report_type_id, file_count: file_count)
    end
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
    report_type_id = ReportType.find_by(name_type: "Lưu nháp", type_report: "Chưa báo cáo").id
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
    report_type_id = ReportType.find_by(name_type: "Chờ duyệt", type_report: "Đang báo cáo").id
    @report.report_type_id =  report_type_id  
    @report.first_submit = Date.current if @report.first_submit.blank?
    @report.save
  end

  def return_report
    report = Report.find(params["report_id"])
    report_type_id = ReportType.find_by(name_type: "Cần bổ sung", type_report: "Đang báo cáo").id
    @report.update(report_type_id: report_type_id)  
    @report.user.notifications.create(content: "Báo cáo của bạn vừa bị từ chối")
  end

  def report_apply
    report = Report.find(params["report_id"])
    if report.last_submit_time > report.report_template.end_date
      report_type_id = ReportType.find_by(name_type: "Đã duyệt", type_report: "Trễ hạn").id
      @report.update(report_type_id: report_type_id)
      @report.user.notifications.create(content: "Báo cáo của bạn đã được duyệt")
    else 
      report_type_id = ReportType.find_by(name_type: "Đã duyệt", type_report: "Đúng hạn").id
      @report.update(report_type_id: report_type_id)
    end
  end

  def show
    add_breadcrumb "CHI TIẾT BÁO CÁO CÁ NHÂN", :report_path
    @report_template_title = JSON.parse(Report.find(params[:id]).data)
    @report_template = Report.find(params[:id])
    @file_count = @report_template.file_count.present? ? JSON.parse(@report_template.file_count) : []
  end

  def edit
    add_breadcrumb "CHỈNH SỬA BÁO CÁO CÁ NHÂN", :edit_report_path
    @report_template_title = JSON.parse(Report.find(params[:id]).data)
    @report_template = Report.find(params[:id])
    report_type = @report_template.report_type&.name_type
    @file_count = @report_template.file_count.present? ? JSON.parse(@report_template.file_count) : []
    @can_send_report = (report_type == "Cần bổ sung" || report_type == "Lưu nháp") ? true :false
  end

  #baocaonhanvien
  def new

  end

  #dánhachkibaocao
  def index
    add_breadcrumb "DANH SÁCH BÁO CÁO CÁ NHÂN", :report_index_path
    @report = current_user.reports.order(:created_at)
    @pagy, @report = pagy(current_user.reports.all, items: 8)
  end

  def download_attachment
    @file = ReportAttachment.find(params[:file_id])
    send_file @file.attachment.path
  end


  def export
    @report = Report.find(params[:report_id])
    data = JSON.parse(@report.data)
    csv = CSV.generate("\uFEFF") do |csv|
      data&.keys&.each_with_index do |key, index|
        csv << ["#{index + 1}. #{key}"]
        csv << data[key].keys + data[key]&.values&.first['title']
        data[key]&.values&.first['content']&.each do |content_arr|
          csv << content_arr
        end
      end
    end
    send_data csv, filename: "#{@report.user.name}_report.csv"
  end
end