class ReportTemplateController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
  end

  def create
    data = {}
    table_keys = JSON.parse(params["table_keys"])
    title_2_title_arr = JSON.parse(params["title_2_title_arr"])
    table_keys.each_with_index do |key, index|
      title_2_title_arr[index].each_with_index do |title_2_arr, i|
        title_2_value = title_2_arr.split(",")
        data[key] = {} unless data[key]
        data[key][title_2_value[0]] = title_2_value.drop(1)
      end
    end
    ReportTemplate.create(data: JSON.generate(data))
  end

  def new
  end

  def edit
    @report_template
  end

  def update
    @report_template.udpate(update_params)
  end
  
  def show
    @report_template_title = JSON.parse(ReportTemplate.find(params[:id]).data)
    @report_template = ReportTemplate.find(params[:id])
  end

  def apply_temple
    raise "this academic year have teamplate yet" if ReportTemplate.where(academic_year_id: @report_template.academic_year_id, is_apply: true).present?
    @report_template.update(is_apply: true)
  end

  private

  def current_template
    @report_template = ReportTemplate.find(params[:id])
  end
end
