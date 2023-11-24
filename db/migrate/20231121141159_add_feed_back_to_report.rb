class AddFeedBackToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :feedback, :text
  end
end
