class HomeController < ApplicationController
  before_action :authenticate_user!

  def page_login
  end

  def page_usinfo
    @user = User.find(params[:user])
  end

  def page_stats
  end

  def report

  end

  def edit
    @user = User.find(params[:id])
    @role = Role.all
    @faculties = Faculty.all
    @subjects = Subject.all
  end

  def update
    @user = User.find(params[:id])
    if @current_user.role != 'admin'
      user.update!(params)
    else
      user.update!(params[:phone_number]) #add this column to database!
    end
  end

  def edit
  end

  def generalReportForm
  end

  def list_staff
  end

  def list_lecturer
  end

  def list_subject
  end

  def list_faculty
  end

  def review_report
  end

  def configuration_page
  end

  def report_upload
  end

  def report_chart
    @report = Report.joins(:report_type, :user)
    #fillter    
    @report = params[:filter_academic] ? @report.where(academic_id: params[:filter_academic]) : @report.where(academic_id: Academic.last.id)
    if params[:filter_role].present?
      @report = @report.where(role: params[:filter_role])
    end
    if params[:filter_subject].present?
      @report = @report.where(user: {subject_id: params[:filter_subject]})
    end
    if params[:filter_faculty].present?
      @report = @report.where(user: {faculty_id: params[:filter_faculty]})
    end
    #
    @khoi_tao = @report.where(report_types: {name_type: 'khoi tao'}).size
    @luu_nhap = @report.where(report_types: {name_type: 'luu nhap'}).size
    @dung_han = @report.where(report_types: {type_report: 'dung han'}).size
    @tre_han = @report.where(report_types: {type_report: 'tre han'}).size
    @can_bo_sung = @report.where(report_types: {name_type: 'can bo sung'}).size
    @da_duyet = @report.where(report_types: {name_type: 'da duyet'}).size
    @cho_duyet = @report.where(report_types: {name_type: 'cho_duyet'}).size
    @data = {
      chart: {
        tong_bao_cao: @report.size,
        khoi_tao: @khoi_tao,
        luu_nhap: @luu_nhap,
        dung_han: @dung_han,
        tre_han: @tre_han,
        can_bo_sung: @can_bo_sung,
        da_duyet: @da_duyet,
        cho_duyet: @cho_duyet
      },
      fillter: {
        filter_academic: params[:filter_academic],
        filter_role: params[:filter_role],
        filter_subject: params[:filter_subject],
        filter_faculty: params[:filter_faculty]
      }
    }
  end
end
