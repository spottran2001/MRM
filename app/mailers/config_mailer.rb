class ConfigMailer < ApplicationMailer

  def start_report(emails, academic)
    @emails = emails
    @academic = academic
    mail(from: 'Report Monthly <reportmonthlyk25pm04@gmail.com>', to: emails, subject: "Thông báo Kỳ báo cáo tháng #{Time.current.strftime('%m-%Y')}")
  end

  def end_report(emails)
    @emails = emails
    mail(from: 'Report Monthly <reportmonthlyk25pm04@gmail.com>', to: emails, subject: "Thông báo Kỳ báo cáo tháng #{Time.current.strftime('%m-%Y')}")
  end

  def deadline(emails)
    @emails = emails
    mail(from: 'Report Monthly <reportmonthlyk25pm04@gmail.com>', to: emails, subject: "Thông báo Kỳ báo cáo tháng #{Time.current.strftime('%m-%Y')}")
  end

  def before_deadline(emails)
    @emails = emails
    mail(from: 'Report Monthly <reportmonthlyk25pm04@gmail.com>', to: emails, subject: "Thông báo Kỳ báo cáo tháng #{Time.current.strftime('%m-%Y')}")
  end

  def before_end(emails)
    @emails = emails
    mail(from: 'Report Monthly <reportmonthlyk25pm04@gmail.com>', to: emails, subject: "Thông báo Kỳ báo cáo tháng #{Time.current.strftime('%m-%Y')}")
  end
end