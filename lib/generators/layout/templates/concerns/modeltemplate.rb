class Modeltemplate
  ##-- Requirements and Concerns ---
  
  ##-- Constants--------------------
  
  ##-- Virtual Attributes ----------
  
  ##-- Validations -----------------
  # validates :email, presence: true
  # validates :username, uniqueness: { case_sensitive: false }
  
  ##-- Callbacks -------------------
  
  ##-- Associations ----------------
  # has_many :roles, dependent: :destroy
  # has_many :users, through: :memberships
  
  ##-- Scopes ----------------------
  # scope :active, -> { where(active: true) }
  
  ##-- Methods ---------------------



end