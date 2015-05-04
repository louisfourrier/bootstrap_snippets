# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  snippet_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Favorite < ActiveRecord::Base
  ##-- Requirements and Concerns ---
  
  ##-- Constants--------------------
  
  ##-- Virtual Attributes ----------
  
  ##-- Validations -----------------
  # validates :email, presence: true
  # validates :username, uniqueness: { case_sensitive: false }
  validates :user, presence: true
  validates :snippet, presence: true
  validates :user, uniqueness: {:scope => [:snippet]}
  
  ##-- Callbacks -------------------
  
  ##-- Associations ----------------
  # has_many :roles, dependent: :destroy
  # has_many :users, through: :memberships
  
  belongs_to :user
  belongs_to :snippet, counter_cache: true
  
  ##-- Scopes ----------------------
  # scope :active, -> { where(active: true) }
  
  ##-- Methods ---------------------
 
end
