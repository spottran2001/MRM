class Report < ApplicationRecord
  belong_to :user
  belongs_to :submiter_admin, class_name: 'User', foreign_key: 'submiter_id', primary_key: 'id', optional: true
  belongs_to :returner_admin, class_name: 'User', foreign_key: 'returner_id', primary_key: 'id', optional: true
  has_many :report_details
end
