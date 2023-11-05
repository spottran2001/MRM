class Report < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :submiter_admin, class_name: 'User', foreign_key: 'submiter_id', primary_key: 'id', optional: true
  belongs_to :returner_admin, class_name: 'User', foreign_key: 'returner_id', primary_key: 'id', optional: true
  has_many :report_details
  belongs_to :report_template
  belongs_to :report_type

  # validate :check_subject

  # def check_subject
  #   if report_template.subject_id != user.subject_id
  #     errors.add(:base, "This template is not a valid for this user")
  #   end
  # end

  def get_status
    if status == "shopper"
      return "Moi tao"
    else
      return status
    end
  end
end
