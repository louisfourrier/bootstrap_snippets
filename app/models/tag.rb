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
#

class Tag < ActiveRecord::Base
  include CommonMethods
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  #mount_uploader :image_url, ImageUrlUploader
  
  validates :name, presence: true, uniqueness: true
  validates :name, length: { in: 2..30 } 
  
  before_save :sanitize_name
  
  after_create :update_research_name
  after_create :update_first_letter
  
  has_many :taggings, dependent: :destroy
  has_many :snippets, :through => :taggings, source: :taggable, source_type: "Snippet"
  
  # Basic sanitize
  def sanitize_name
    self.name = self.name.strip.downcase
  end 
  
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
