class ChangeStringToTextTypeAtReportAndReportTemplate < ActiveRecord::Migration[7.0]
  def up
    remove_column :report_templates, :title
    remove_column :reports, :template_keys

    add_column :report_templates, :data, :text
    add_column :reports, :data, :text
  end

  def down
    remove_column :report_templates, :data
    remove_column :reports, :data

    add_column :report_templates, :title, :string
    add_column :reports, :template_keys, :string
  end
end
