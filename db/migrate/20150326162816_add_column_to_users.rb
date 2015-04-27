class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pseudo, :string
    add_column :users, :is_administrator, :boolean, default: false
    add_column :users, :is_real, :boolean, default: true
     
  end
end
