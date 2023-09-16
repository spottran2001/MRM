class Report < ApplicationRecord
  belongs_to :user
  belongs_to :submiter_admin, class_name: 'User', foreign_key: 'submiter_id', primary_key: 'id', optional: true
  belongs_to :returner_admin, class_name: 'User', foreign_key: 'returner_id', primary_key: 'id', optional: true
  has_many :report_details

  # validate :check_subject

  # def check_subject
  #   if report_template.subject_id != user.subject_id
  #     errors.add(:base, "This template is not a valid for this user")
  #   end
  # end
end
