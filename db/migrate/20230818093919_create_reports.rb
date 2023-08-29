class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :template_keys
      t.datetime :last_submit_time
      t.datetime :confirm_time
      t.datetime :return_time
      t.string :status, null: false, default: "shopper"
      t.integer :submiter_id
      t.integer :returner_id
      t.string :report_type

      t.timestamps
    end

    add_reference :reports, :user , index: true
  end
end
