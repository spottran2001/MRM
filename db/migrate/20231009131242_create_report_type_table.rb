class CreateReportTypeTable < ActiveRecord::Migration[7.0]
  def up
    create_table :report_types do |t|
      t.string :name_type
      t.string :type_report

      t.timestamps
    end
    add_reference :reports, :report_type, index: true
  end

  def down
    drop_table :report_types
    remove_reference :reports, :report_type
  end
end
