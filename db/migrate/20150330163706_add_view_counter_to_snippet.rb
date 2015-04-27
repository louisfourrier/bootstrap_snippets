class AddViewCounterToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :views_count, :integer, default: 0
  end
end
