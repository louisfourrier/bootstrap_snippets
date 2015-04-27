class AddIframeUrlToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :iframe_url_original, :text
    add_column :snippets, :iframe_html_content, :text
  end
end
