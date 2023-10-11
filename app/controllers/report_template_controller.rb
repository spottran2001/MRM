class ReportTemplateController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

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
    ReportTemplate.find(params[:id]).update(data: JSON.generate(data),role: template_role, name: template_name, year: template_year)
  end
  
  def show
    @report_template_title = JSON.parse(ReportTemplate.find(params[:id]).data)
    @report_template = ReportTemplate.find(params[:id])
  end

  def submit_report
    template = ReportTemplate.find(params[:report_template_id])
    template.update!(is_apply: true)
    redirect_to report_template_management_path
  end

  def apply_temple
    #raise "this academic year have teamplate yet" if ReportTemplate.where(academic_year_id: @report_template.academic_year_id, is_apply: true).present?
    #@report_template.update(is_apply: true)
    ActiveRecord::Base.transaction do 
      #YearTemplate(staff_template_id, subject_template_id, faculty_template_id, teacher_template_id,start_date, end_date, deadline)
      staff_template_id = params["staff_id"]
      subject_template_id = params["subject_id"]
      faculty_template_id = params["faculty_id"]
      teacher_template_id = params["teacher_id"]
      start_date = params["start_date"]
      end_date = params["end_date"]
      name = params["name"]
      staff_template = ReportTemplate.find(staff_template_id)
      subject_template = ReportTemplate.find(subject_template_id)
      faculty_template = ReportTemplate.find(faculty_template_id)
      teacher_template = ReportTemplate.find(teacher_template_id)
      report_type = ReportType.find_by(name_type: 'khoi tao', type_report: 'chua bao cao')
      academic = Academic.create(
        staff_report_id: staff_template_id, subject_report_id: subject_template_id,
        faculty_report_id: faculty_template_id, teacher_report_id: teacher_template_id,
        name: name
      )
      User.all.each do |u|
        if u.role.include?('staff')
          u.reports.create(data: staff_template.data, year: staff_template.year, role: staff_template.role, name: name, report_types_id: report_type.id, academic_id: academic.id)
        elsif u.role.include?('subject')
          u.reports.create(data: subject_template.data, year: subject_template.year, role: subject_template.role, name: name, report_types_id: report_type.id, academic_id: academic.id)
        elsif u.role.include?('faculty')
          u.reports.create(data: faculty_template.data, year: faculty_template.year, role: faculty_template.role, name: name, report_types_id: report_type.id, academic_id: academic.id)
        elsif u.role.include?('teacher')
          u.reports.create(data: teacher_template.data, year: teacher_template.year, role: teacher_template.role, name: name, report_types_id: report_type.id, academic_id: academic.id)
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
