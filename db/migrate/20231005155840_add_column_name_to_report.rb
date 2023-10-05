class AddColumnNameToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :name, :string 
  end
end
