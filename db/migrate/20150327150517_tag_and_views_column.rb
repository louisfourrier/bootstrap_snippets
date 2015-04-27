class TagAndViewsColumn < ActiveRecord::Migration
  def change
    add_column :tags, :is_bootstrap, :boolean, default: false
    add_column :snippets, :bootstrapversion_id, :integer
  end
end
