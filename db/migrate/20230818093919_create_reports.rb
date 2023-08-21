class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :name
      t.json :title, null: false
      t.boolean :is_apply
      t.datetime :apply_time
      t.datetime :last_submit_time
      t.datetime :confirm_time
      t.datetime :return_time
      t.string :status, null: false, default: "shopper"
      t.integer :submiter_id
      t.integer :returner_id
      t.string :report_type

      t.timestamps
    end

    add_reference :users, :reports , index: true
  end
end
