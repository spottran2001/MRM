class AddFiledToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :string
    add_reference :users, :faculty , index: true
    add_reference :users, :subject , index: true
  end
end
