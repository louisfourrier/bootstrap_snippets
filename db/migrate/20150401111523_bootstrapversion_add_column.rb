class BootstrapversionAddColumn < ActiveRecord::Migration
  def change
    remove_column :bootstrapversions, :url_name
    add_column :bootstrapversions, :css_assets_url, :text
    add_column :bootstrapversions, :js_assets_url, :text
  end
end
