class AddReferenceReportTemplateToReport < ActiveRecord::Migration[7.0]
  def change
    add_reference :reports, :report_template, index: true
  end
end
