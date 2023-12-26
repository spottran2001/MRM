class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(from: 'Report Monthly <reportmonthlyk25pm04@gmail.com>', to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def start_report(user)
    @user = user
    mail(from: 'Report Monthly <reportmonthlyk25pm04@gmail.com>', to: @user.email, subject: "Thông báo Kỳ báo cáo tháng #{Time.current.strftime('%m-%Y')}")
  end

  def end_report(user, report)
    @report = report
    @user = user
    mail(from: 'Report Monthly <reportmonthlyk25pm04@gmail.com>', to: @user.email, subject: "Thông báo Kỳ báo cáo tháng #{Time.current.strftime('%m-%Y')}")
  end
end