class ConfigurationController < ApplicationController
  before_action :authenticate_user!

  def index
    add_breadcrumb "QUẢN LÝ CẤU HÌNH", :configuration_page_path
    @config = ::Configuration.last
  end

  def update
    config = ::Configuration.find(params[:id])
    config.update(config_params)
    redirect_to configuration_index_path
  end

  private

  def config_params
    params.require(:configuration).permit(:deadline, :send_email_before_deadline, :send_email_before_end_date)
  end
end
