class AddColumnToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :is_analysed, :boolean, default: false
  end
end
