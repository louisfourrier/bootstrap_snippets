class AddColumnsToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :research_name, :text
  end
end
