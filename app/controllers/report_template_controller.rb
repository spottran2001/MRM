class ReportTemplateController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    @report_templates = ReportTemplate.all.order(:created_at)
  end

  def create
    data = {}
    template_name = JSON.parse(params["template_name"])
    template_role = JSON.parse(params["template_role"])
    template_year = JSON.parse(params["template_year"])
    table_keys = JSON.parse(params["table_keys"])
    title_2_title_arr = JSON.parse(params["title_2_title_arr"])
    table_keys.each_with_index do |key, index|
      title_2_title_arr[index].each do |title_2_arr|
        data[key] = {} unless data[key]
        data[key][title_2_arr[0]] = {} if data[key][title_2_arr[0]].blank?
        data[key][title_2_arr[0]][:title] = title_2_arr.drop(1)
      end
    end
    ReportTemplate.create(data: JSON.generate(data),role: template_role, name: template_name, year: template_year)
  end

  def new
  end

  def edit
    @report_template_title = JSON.parse(ReportTemplate.find(params[:id]).data)
    @report_template = ReportTemplate.find(params[:id])
  end

  def update
    data = {}
    table_keys = JSON.parse(params["table_keys"])
    title_2_title_arr = JSON.parse(params["title_2_title_arr"])
    table_keys.each_with_index do |key, index|
      title_2_title_arr[index].each do |title_2_arr|
        data[key] = {} unless data[key]
        data[key][title_2_arr[0]] = {} if data[key][title_2_arr[0]].blank?
        data[key][title_2_arr[0]][:title] = title_2_arr.drop(1)
      end
    end
    ReportTemplate.find(params[:id]).update(data: JSON.generate(data))
  end
  
  def show
    @report_template_title = JSON.parse(ReportTemplate.find(params[:id]).data)
    @report_template = ReportTemplate.find(params[:id])
  end

  def apply_temple
    #raise "this academic year have teamplate yet" if ReportTemplate.where(academic_year_id: @report_template.academic_year_id, is_apply: true).present?
    #@report_template.update(is_apply: true)
    ActiveRecord::Base.transaction do 
      #YearTemplate(staff_template_id, subject_template_id, faculty_template_id, teacher_template_id,start_date, end_date, deadline)
      staff_template_id, subject_template_id, faculty_template_id, teacher_template_id,start_date, end_date, deadline = ''
      staff_template_data = ReportTemplate.find(staff_template_id).data
      subject_template_data = ReportTemplate.find(subject_template_id).data
      faculty_template_data = ReportTemplate.find(faculty_template_id).data
      teacher_template_data = ReportTemplate.find(teacher_template_id).data
      User.all.each do |u|
        if u.role.include?('Nhân viên')
          u.template.create(data: staff_template_data)
        elsif u.role.include?('Giảng viên')
          u.template.create(data: subject_template_data)
        elsif u.role.include?('Phụ trách bộ môn')
          u.template.create(data: faculty_template_data)
        elsif u.role.include?('Ban chủ nhiệm khoa')
          u.template.create(data: teacher_template_data)
        end
      end
    end
  end

  def report_template_management
    @report_templates = ReportTemplate.all
  end

  private

  def current_template
    @report_template = ReportTemplate.find(params[:id])
  end
end
