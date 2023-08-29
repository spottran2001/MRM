  class CreateReportTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :report_templates do |t|
      t.datetime :apply_time
      t.boolean :is_apply
      t.string :title
      t.integer :uid
      t.integer :academic_year_id   
      t.integer :subject_id
      t.date :deadline
      
 
      t.timestamps
    end
  end
end
