class ReportAttachment < ApplicationRecord
  belongs_to :report

  mount_uploader :attachment, AttachmentUploader, destroy: true
end
