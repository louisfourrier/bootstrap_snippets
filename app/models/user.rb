# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime
#  updated_at             :datetime
#  pseudo                 :string
#  is_administrator       :boolean          default(FALSE)
#  is_real                :boolean          default(TRUE)
#  slug                   :string
#

class User < ActiveRecord::Base
  ##-- Requirements and Concerns ---
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  include CommonMethods
  extend FriendlyId
  friendly_id :pseudo, use: :slugged
  ##-- Constants--------------------

  ##-- Virtual Attributes ----------

  ##-- Validations -----------------
  # validates :email, presence: true
  # validates :username, uniqueness: { case_sensitive: false }
  validates :pseudo, presence:true
  validates :pseudo, uniqueness: { case_sensitive: false }

  ##-- Callbacks -------------------

  ##-- Associations ----------------
  # has_many :roles, dependent: :destroy
  # has_many :users, through: :memberships
  has_many :snippets
  
  has_many :favorites
  has_many :favorite_snippets, through: :favorites, :class_name => "Snippet", :source => :snippet

  ##-- Scopes ----------------------
  # scope :active, -> { where(active: true) }

  ##-- Methods ---------------------
  
  # Find the admin and updates the status
  def self.define_administrator
    admin = self.find_by(:email => "louis.fourrier@gmail.com")
    admin.update(:is_administrator => true)
  end
  
  
end
