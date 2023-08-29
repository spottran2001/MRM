class CreateFaculties < ActiveRecord::Migration[7.0]
  def change
    create_table :faculties do |t|
      t.string :name
      t.integer :uid

      t.timestamps
    end
  end
end
