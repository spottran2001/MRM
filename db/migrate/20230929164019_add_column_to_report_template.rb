class AddColumnToReportTemplate < ActiveRecord::Migration[7.0]
  def change
    add_column :report_templates, :name, :string
    add_column :report_templates, :year, :string 
    add_column :report_templates, :role, :string 
  end
end
