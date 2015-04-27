class TagChange < ActiveRecord::Migration
  def change
    add_column :tags, :snippets_count, :integer
    add_index :tags, :slug
    add_index :tags, :snippets_count
  end
end
