class AddFileCountToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :file_count, :string
  end
end
