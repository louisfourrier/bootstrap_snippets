# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  tag_id        :integer
#  taggable_id   :integer
#  taggable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Tagging < ActiveRecord::Base
  ##-- Requirements and Concerns ---

  ##-- Constants--------------------

  ##-- Virtual Attributes ----------

  ##-- Validations -----------------
  # validates :email, presence: true
  # validates :username, uniqueness: { case_sensitive: false }
  validates :tag, presence: true
  validates :tag, uniqueness: {:scope => [:taggable_id, :taggable_type]}

  ##-- Callbacks -------------------

  ##-- Associations ----------------
  # has_many :roles, dependent: :destroy
  # has_many :users, through: :memberships
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  
  has_many :snippets, :through => :taggings, source: :taggable, source_type: "Snippet"

  ##-- Scopes ----------------------
  # scope :active, -> { where(active: true) }

  ##-- Methods ---------------------

end
