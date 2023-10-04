class AddColumnToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :year, :string 
    add_column :reports, :role, :string 
  end
end
