class AddFavoriteCountAndTaggingCount < ActiveRecord::Migration
  def change
    add_column :snippets, :favorites_count, :integer, :null => false, :default => 0
    add_column :tags, :taggings_count, :integer, :null => false, :default => 0
    
    Tagging.counter_culture_fix_counts
    Favorite.counter_culture_fix_counts
  end
end
