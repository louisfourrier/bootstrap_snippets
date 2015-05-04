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
  belongs_to :snippet
  
  ##-- Scopes ----------------------
  # scope :active, -> { where(active: true) }
  
  ##-- Methods ---------------------
 
end
