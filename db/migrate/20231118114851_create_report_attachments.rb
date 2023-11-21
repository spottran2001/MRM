class CreateReportAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :report_attachments do |t|
      t.string :attachment
      t.belongs_to :report

      t.timestamps
    end
  end
end
