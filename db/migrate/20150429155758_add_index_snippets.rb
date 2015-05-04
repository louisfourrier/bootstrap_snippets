class AddIndexSnippets < ActiveRecord::Migration
  def change
    add_index :snippets, :status
  end
end
