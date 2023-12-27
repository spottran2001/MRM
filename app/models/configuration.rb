class Configuration < ApplicationRecord
  validates :deadline, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }

  def mailer
    academic = Academic.where("end_date >= '#{DateTime.current}' and start_date <= '#{DateTime.current}'")
    emails = User.where.not("role like '%admin%'").pluck(:email)
    if academic.last && !mailer_start
      ConfigMailer.start_report(emails, academic.last).deliver_now
      self.update(mailer_start: true, mailer_end: false, mailer_deadline: false, mailer_before_deadline: false, mailer_before_end_date: false)
    end

    if !mailer_before_deadline
      unless send_email_before_deadline != DateTime.current.day
        ConfigMailer.before_deadline(emails).deliver_now
        self.update(mailer_before_deadline: true)
      end
    end

    if !mailer_deadline
      unless deadline != DateTime.current.day
        ConfigMailer.deadline(emails).deliver_now
        self.update(mailer_deadline: true)
      end
    end

    if !mailer_before_end_date
      unless send_email_before_end_date != DateTime.current.day
        ConfigMailer.before_end(emails).deliver_now
        self.update(mailer_before_end_date: true)
      end
    end
    
    if !mailer_end && academic.last
      unless academic.last.end_date&.day != DateTime.current.day
        ConfigMailer.end_report(emails).deliver_now
        self.update(mailer_end: true, mailer_start: false, mailer_deadline: false, mailer_before_deadline: false, mailer_before_end_date: false)
      end
    end
  end
end
