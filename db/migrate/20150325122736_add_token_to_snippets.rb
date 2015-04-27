class AddTokenToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :token, :string
    add_index :snippets, :token
  end
end
