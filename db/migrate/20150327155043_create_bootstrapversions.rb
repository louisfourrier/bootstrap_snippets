class CreateBootstrapversions < ActiveRecord::Migration
  def change
    create_table :bootstrapversions do |t|
      t.string :name
      t.text :url_name

      t.timestamps null: false
    end
  end
end
