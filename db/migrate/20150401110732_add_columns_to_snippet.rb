class AddColumnsToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :is_scraped, :boolean, default: false
    add_column :snippets, :approved, :boolean, default: false
    add_column :snippets, :refused, :boolean, default: false
    add_column :snippets, :send_for_approval, :boolean, default: false
    add_column :snippets, :comment_for_refusal, :text
  end
end
