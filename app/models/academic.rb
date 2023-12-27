class Academic < ApplicationRecord
  belongs_to :staff_template, class_name: 'ReportTemplate', foreign_key: 'staff_report_id', primary_key: 'id', optional: true
  belongs_to :subject_report, class_name: 'ReportTemplate', foreign_key: 'subject_report_id', primary_key: 'id', optional: true
  belongs_to :faculty_report, class_name: 'ReportTemplate', foreign_key: 'faculty_report_id', primary_key: 'id', optional: true
  belongs_to :teacher_report, class_name: 'ReportTemplate', foreign_key: 'teacher_report_id', primary_key: 'id', optional: true

  validate :check_academic


  def check_academic
    errors.add(:base, message: "Đã tồn tại kì báo cáo trong thời gian này") if Academic.where("(end_date >= '#{self.start_date.to_datetime}' and start_date <= '#{self.start_date.to_datetime}') or (end_date >= '#{self.end_date.to_datetime}' and start_date <= '#{self.end_date.to_datetime}')").present?
  end
end