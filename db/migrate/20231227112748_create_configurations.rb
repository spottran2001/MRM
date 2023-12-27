class CreateConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :configurations do |t|
      t.integer :deadline
      t.integer :send_email_before_deadline
      t.integer :send_email_before_end_date
      t.boolean :mailer_start, default: false
      t.boolean :mailer_end, default: false
      t.boolean :mailer_deadline, default: false
      t.boolean :mailer_before_deadline, default: false
      t.boolean :mailer_before_end_date, default: false
      
      t.timestamps
    end
  end
end
