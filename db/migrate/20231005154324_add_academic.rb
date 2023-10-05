class AddAcademic < ActiveRecord::Migration[7.0]
  def change
    create_table :academics do |t|
      t.string :name
      t.integer :staff_report_id
      t.integer :subject_report_id 
      t.integer :faculty_report_id 
      t.integer :teacher_report_id 
      t.string :report_type
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end

  end
end
