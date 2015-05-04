# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string
#  image_url      :text
#  first_letter   :string
#  research_name  :string
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  snippets_count :integer
#  is_bootstrap   :boolean          default(FALSE)
#  taggings_count :integer          default(0), not null
#

class Tag < ActiveRecord::Base
  include CommonMethods
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  #mount_uploader :image_url, ImageUrlUploader
  
  validates :name, presence: true, uniqueness: true
  validates :name, length: { in: 2..30 } 
  
  before_validation :sanitize_name
  
  after_create :update_research_name
  after_create :update_first_letter
  
  has_many :taggings, dependent: :destroy
  has_many :snippets, :through => :taggings, source: :taggable, source_type: "Snippet"
  
  # Basic sanitize
  def sanitize_name
    self.name = Tag.sanitize_name(self.name)
  end
  
  # Class method to sanitier the name
  # TODO Problem is to check the name before create
  def self.sanitize_name(name)
    return name.to_s.strip.downcase
  end
  
  # Method for researrch name in common methods
  def title 
    self.name
  end 
  
  # Check the counters for taggings
  def self.check_favorite_count
    self.find_each { |tag| Tag.reset_counters(tag.id, :taggings) }
  end

  
  # Distinguish tags from the bootstrap version of the snippets
  def update_bootstrap_version
    names = Bootstrapversion.name_list
    if names.include?(self.name)
      self.update_column(:is_bootstrap, true)
    end
  end
  
  # Update the snippets counter
  def update_snippets_count
    self.update(:snippets_count => self.snippets.count)
  end
end
