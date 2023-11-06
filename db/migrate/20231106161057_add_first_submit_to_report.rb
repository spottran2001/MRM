class AddFirstSubmitToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :first_submit, :date
  end
end
