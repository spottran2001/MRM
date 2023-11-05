class AcademicController < ApplicationController
  before_action :authenticate_user!

  def index
    @academic = Academic.all.order(:created_at)
  end

  def show 
    @academic = Academic.find(params[:id])
    users = User.all
      @pagy, @users = pagy(users.all, items: 8)
  end
end
