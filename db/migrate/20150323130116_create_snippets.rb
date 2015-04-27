class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.text :title
      t.text :slug
      t.text :image_url
      t.text :original_url
      t.text :html_content
      t.text :html_code
      t.text :css_code
      t.text :js_code
      t.text :description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
