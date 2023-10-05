class AcademicController < ApplicationController
  before_action :authenticate_user!

  def index
    @academic = Academic.all.order(:created_at)
  end
end
