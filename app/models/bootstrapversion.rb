# == Schema Information
#
# Table name: bootstrapversions
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  css_assets_url :text
#  js_assets_url  :text
#

class Bootstrapversion < ActiveRecord::Base
  ##-- Requirements and Concerns ---
  
  ##-- Constants--------------------
  
  ##-- Virtual Attributes ----------
  
  ##-- Validations -----------------
  # validates :email, presence: true
  # validates :username, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  
  ##-- Callbacks -------------------
  
  ##-- Associations ----------------
  # has_many :roles, dependent: :destroy
  # has_many :users, through: :memberships
  has_many :snippets
  
  ##-- Scopes ----------------------
  # scope :active, -> { where(active: true) }
  
  ##-- Methods ---------------------
  
  def self.name_list
    ["3.2.0", "3.1.0", "3.3.0", "3.0.3", "3.0.1", "3.0.2", "3.0.0", "2.3.2"]
  end
  
  def bootstrap_name
    return "Bootstrap " + self.name
  end
  
  def css_url
    return "http://maxcdn.bootstrapcdn.com/bootstrap/" + self.name + "/css/bootstrap.min.css"
  end
  
  def js_url
    return "http://maxcdn.bootstrapcdn.com/bootstrap/"+ self.name + "/js/bootstrap.min.js"
  end
  
  def self.create_first_versions
    self.name_list.each do |name|
      Bootstrapversion.create(:name => name)
    end
  end
  
end
