class CreateReportDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :report_details do |t|
      t.json :report_value, null: false
      t.string :report_keys, null: false
      t.timestamps
    end
    add_reference :reports, :report_details , index: true
  end
end
