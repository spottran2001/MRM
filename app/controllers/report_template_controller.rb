class ReportTemplateController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    @report_templates = ReportTemplate.all.order(:created_at)
  end

  def create
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
    ReportTemplate.create(data: JSON.generate(data))
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
    raise "this academic year have teamplate yet" if ReportTemplate.where(academic_year_id: @report_template.academic_year_id, is_apply: true).present?
    @report_template.update(is_apply: true)
  end

  def report_template_management

  end

  private

  def current_template
    @report_template = ReportTemplate.find(params[:id])
  end
end
