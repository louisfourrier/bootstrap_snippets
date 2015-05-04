# == Schema Information
#
# Table name: snippets
#
#  id                  :integer          not null, primary key
#  title               :text
#  slug                :text
#  image_url           :text
#  original_url        :text
#  html_content        :text
#  html_code           :text
#  css_code            :text
#  js_code             :text
#  description         :text
#  user_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  iframe_url_original :text
#  iframe_html_content :text
#  research_name       :text
#  token               :string
#  bootstrapversion_id :integer
#  views_count         :integer          default(0)
#  is_scraped          :boolean          default(FALSE)
#  approved            :boolean          default(FALSE)
#  refused             :boolean          default(FALSE)
#  send_for_approval   :boolean          default(FALSE)
#  comment_for_refusal :text
#  is_analysed         :boolean          default(FALSE)
#  status              :integer          default(0)
#  favorites_count     :integer          default(0), not null
#

class Snippet < ActiveRecord::Base
  ##-- Requirements and Concerns ---
  include CommonMethods
  include Taggable

  #extend FriendlyId
  #friendly_id :title, use: :slugged

  ##-- Constants--------------------

  ##-- Virtual Attributes ----------
  attr_writer :bootstrap_version

  ##-- Validations -----------------
  # validates :email, presence: true
  # validates :username, uniqueness: { case_sensitive: false }
  # validates_uniqueness_of :acronym, :allow_blank => true, :scope => [:group_id], :case_sensitive => false
  validates :title, presence: true
  validates :original_url, uniqueness: { :allow_blank => true, :scope => [:is_scraped] }

  #validates :original_url, presence: true
  #validates :original_url, uniqueness: true

  ##-- Callbacks -------------------
  after_save :update_research_name
  after_create :generate_random_token
  before_update  :save_bootstrap_version

  ##-- Associations ----------------
  # has_many :roles, dependent: :destroy
  # has_many :users, through: :memberships
  belongs_to :user
  belongs_to :bootstrapversion
  has_many :similar_snippets, through: :tags, :class_name => "Snippet", :source => :snippets

  has_many :favorites
  has_many :fans, through: :favorites, :class_name => "User", :source => :user
  ##-- Scopes ----------------------
  scope :approved, -> { where(status: 2) }
  scope :not_approved, -> { where(status: 2).not }
  scope :waiting, -> { where(status: 1) }
  
  ##-- Methods ---------------------
  # Easy method for pretty URLS
  def to_param
    return "#{id}-#{title}".parameterize
  end
  
  # Method that handles all the filtering of the params
  def self.filter(attributes)
    attributes.inject(self) do |scope, (key, value)|
      #return scope.scoped if value.blank?
      if value.blank?
        scope.all
      else
          case key.to_sym
          when :bootstrap_version
            bootstrap_version = Bootstrapversion.find_by(:name => "%#{value}%")
            scope.where("snippets.bootstrapversion_id = ?", bootstrap_version.id)
          when :search_name # regexp search
            scope.where('snippets.title ilike ? OR snippets.research_name ilike ?', "%#{value}%", "%#{value}%")
          when :starting_letter # regexp search
            letter = I18n.transliterate(value.to_s.strip.downcase).to_s
            puts letter
            scope.where('snippets.title ILIKE ? OR snippets.research_name ILIKE ?', "%#{letter}%", "%#{letter}%")
          when :status
            status = "#{value}".to_s.to_i
            scope.where(:status => status)
          when :order # order=field-(ASC|DESC)
            attribute, order = value.split("-") 
            scope.order("#{self.table_name}.#{attribute} #{order}")
          else # unknown key (do nothing or raise error, as you prefer to)
          scope.all
          end 
      end
    end
  end
  
  #Snippet.filter({:starting_letter => "image"})

  # Class method to create a new snippet from scratch. Pass the User etc...
  def self.create_new(user)
    snippet = self.new(:title => "New Snippet", :html_code => "<h3>Write the HTML code here</h3>")
    user.snippets << snippet
    Bootstrapversion.where('name = ?', "3.3.0").first.snippets << snippet
    return snippet
  end

  # Method to create a new snippet from a fork
  def create_fork_new(user)
    new_snippet = user.snippets.build(:title => "Fork of : " + self.title.to_s, :html_code => self.html_code, :css_code => self.css_code, :js_code => self.js_code, :bootstrapversion_id => self.bootstrapversion.id)
    new_snippet.save
    self.tags.each do |t|
      new_snippet.tags << t
    end
    return new_snippet
  end

  # Puts the snippet in the favorite of the user
  def favorite_from(user)
    if user.favorite_snippets.find_by(:id => self.id)
      self.fans.destroy(user)
      return "Snippet removed from your favorites"
    else
      self.fans << user
      return "Snippet now in favorites"
    end
  end

  def is_favorite(user)
    return !user.favorite_snippets.find_by(:id => self.id).nil?
  end

  # Defavorite the snippet from the user
  def defavorite_from(user)
    if user.favorite_snippets.find_by(:id => self.id)
      user.favorite_snippets.destroy(self)
      return "Snippet correctly removed from favorites"
    else
      return "Snippet not in favorites"
    end
  end

  ## STATUS RELATED METHODS
  # Status 0 nothing, 1 Waiting, 2 Approved, 3 Refused

  # Method that permits for the administrator to change the status of the snippet
  def admin_status_update(status)
    status = status.to_i
    if status == 2
      self.update_column(:status, 2)
      return "Accepted"
    elsif status == 3
      self.update_column(:status, 3)
      return "Refused"
    elsif status == 1
      self.update_column(:status, 1)
      return "Waiting"
    end
  end

  # Puts the snippet in the waiting
  def user_status_update(status)
    status = status.to_i
    if status == 0
      self.update_column(:status, 0)
      return "Hidden"
    elsif status == 1
      self.update_column(:status, 1)
      return "Waiting for approval"
    end
  end

  def human_status
    case self.status.to_i
    when 0
      return "Snippet Hidden"
    when 1
      return "Snippet Waiting for approval"
    when 2
      return "Snippet Approved"
    when 3
      return "Snippet Refused by administrators"
    else
    return "Unknown Status"
    end
  end

  # If the snippet needs to display a put in waiting area ?
  def need_waiting?
    if self.status == 0 || self.status == 3
    return true
    else
    return false
    end
  end

  ## END OF STATUS METHODS

  # Find the snippets that share the tags of the snippet
  def get_similar_snippets(number)
    return self.similar_snippets.approved.order('RANDOM()').first(number.to_i)
  end

  def bootstrap_version
    if @bootstrap_version
    return @bootstrap_version
    elsif self.bootstrapversion
    return self.bootstrapversion.name
    else
      return nil
    end
  end

  ### FOR PARSING ###

  # Convert the content in Nokogiri Nodes
  def html_content_to_html
    html = Nokogiri::HTML(self.html_content)
  end

  # Convert the content of the Iframe in Nokogiri Nodes
  def html_iframe_to_html
    html = Nokogiri::HTML(self.iframe_html_content)
  end

  def snippet_preview
    html = self.html_iframe_to_html
  end

  # Get the css code
  def get_css_code
    begin
      return self.snippet_preview.css('head style').first.text.strip
    rescue
      return ""
    end
  end

  # Update the CSS code in the field
  def update_css_code
    self.update_column(:css_code, self.get_css_code)
  end

  def get_js_code
    begin
      return  self.snippet_preview.css('body script').first.text.to_s.strip
    rescue
      return ""
    end
  end

  # Update the JS code in the field
  def update_js_code
    self.update_column(:js_code, self.get_js_code)
  end

  def get_html_code
    code = self.snippet_preview.css('body').first
    if code
      code.css('script').remove
    return code.inner_html.to_s.strip
    else
      return ""
    end
  end

  # Update the JS code in the field
  def update_html_code
    self.update_column(:html_code, self.get_html_code)
  end

  def get_raw_html_code
    code = self.snippet_preview.css('body').first.to_s
  end

  # Find the URL of the Iframe to have a clear Iframe Html Content
  def update_original_iframe_url
    begin
      iframe_url = self.html_content_to_html.css('iframe').first['src'].to_s
      self.update(:iframe_url_original => iframe_url)
    rescue
      puts "error in the update"
    end
  end

  def update_number_views
    begin
      text = self.html_content_to_html.css('#action-bar > a.btn.btn-default.disabled').text
      nb = text.strip.split(' ').first.gsub!('K', '').to_s.to_f
      nb = nb * 1000
      self.update_column(:views_count, nb.to_i)
    rescue
      puts "Error while updating the number of views"
    end
  end

  # Get the tags in the main page of the snippet
  def get_tags
    html = self.html_content_to_html
    array =[]
    tags = html.css('#tags a span')
    tags.each do |tag|
      puts tag
      array << tag.text
    end

    array.each do |t|
      sanitize_name = Tag.sanitize_name(t.to_s)
      tag = Tag.find_or_create_by(name: sanitize_name)
      begin
        self.tags << tag
      rescue
        puts "Already taken"
      end
    end
  end

  # Get the username and create the instance
  def update_username
    html = self.html_content_to_html
    username = html.css('.title-bar h4 a').first.text
    email = username + "@fakelouis.com"
    user = User.find_by(:pseudo => username)
    if user.nil?
      user = User.new(:pseudo => username, :email => email, :password => 'password123', :password_confirmation => 'password123', :is_real => false)
      user.save(:validate => false)
    end
    if user
    self.user = user
    self.save
    else

    end
  end

  # Find and update the bootstrap version
  def get_bootstrap_version
    version = self.tags.where('is_bootstrap = ?', true)
    if version.nil? or version.empty?
      return
    else
      b = version.first.name
      v = Bootstrapversion.find_by(:name => b)
      if v
      v.snippets << self
      end
    end
  end

  # Global operations after a crawl to update the correct fields
  def global_update_crawler
    self.update_original_iframe_url
    self.update_html_code
    self.update_js_code
    self.update_css_code
    self.get_tags
    self.update_username
    self.get_bootstrap_version
    self.update_number_views
    self.update_column(:is_analysed, true)
  end

  def global_code_update
    self.update_html_code
    self.update_js_code
    self.update_css_code
  end
  
  def self.check_favorite_count
    self.find_each { |snippet| Snippet.reset_counters(snippet.id, :favorites) }
  end

  # Snippet.class_method('global_update_crawler')

  private

  # Save the bootstrap version given by the virtual attribute bootstrap_version
  def save_bootstrap_version
    if self.bootstrap_version.nil?
      bversion_id = Bootstrapversion.where('name = ?', "3.3.0").first.id
    self.bootstrapversion_id = bversion_id
    elsif @bootstrap_version.present?
      bversion = Bootstrapversion.where('name = ?', @bootstrap_version).first || Bootstrapversion.where('name = ?', "3.3.0").first
    bversion_id = bversion.id
    self.bootstrapversion_id = bversion.id
    end
  end

  def generate_random_token
    require 'securerandom'
    random_string = SecureRandom.hex
    while(!Snippet.where(token: random_string).empty?)
      random_string = SecureRandom.hex
    end
    self.update_column(:token, random_string)
  end

end
