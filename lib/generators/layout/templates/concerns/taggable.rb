module Taggable
  extend ActiveSupport::Concern

  # Module that is added to all the class that need an alert system reporting errors.
  # Add an alerts has_many associations
  included do
    attr_writer :tags_list
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings
    
    after_save :save_tags_list
  end
  
  def tags_list
    # tags.map(&:name).join(", ")
    @tags_list || self.tags.pluck(:name).join(",")
  end

  def save_tags_list
    tags = self.tags_list.split(',')
    tags_id = []
    
    tags.each do |name|
      tag = Tag.find_or_create_by(name: name.strip.downcase)
      tags_id << tag.id
    end
    
    puts "Les tags_id " +  tags_id.to_s
    self.tag_ids = tags_id.uniq

  end

  module ClassMethods
  end
  
  
  

end