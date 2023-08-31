class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :content
      t.integer :user_id
      t.boolean :have_read
      
      t.timestamps
    end
  end
end
