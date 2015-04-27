class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.text :image_url
      t.string :first_letter
      t.string :research_name
      t.string :slug

      t.timestamps null: false
    end
  end
end
