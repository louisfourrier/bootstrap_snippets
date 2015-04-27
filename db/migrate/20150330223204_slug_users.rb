class SlugUsers < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_index :users, :pseudo
    add_index :users, :slug
  end
end
