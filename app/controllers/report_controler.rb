class Report < ApplicationController
  def index
  end

  def create
    @report = params
  end
end
