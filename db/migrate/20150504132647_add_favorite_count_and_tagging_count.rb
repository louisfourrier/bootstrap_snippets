class AddFavoriteCountAndTaggingCount < ActiveRecord::Migration
  def change
    add_column :snippets, :favorites_count, :integer, :null => false, :default => 0
    add_column :tags, :taggings_count, :integer, :null => false, :default => 0
    
    Snippet.check_favorites_count
    Tag.check_taggings_count
  end
end
