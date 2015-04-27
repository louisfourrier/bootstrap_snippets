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
  ##-- Scopes ----------------------
  # scope :active, -> { where(active: true) }
  ##-- Methods ---------------------
  # Easy method for pretty URLS
  def to_param
    return "#{id}-#{title}".parameterize
  end

  # Class method to create a new snippet from scratch. Pass the User etc...
  def self.create_new(user)
    snippet = self.new(:title => "New Snippet", :html_code => "<h3>Write the HTML code here</h3>")
    user.snippets << snippet
    Bootstrapversion.where('name = ?', "3.3.0").first.snippets << snippet
    return snippet
  end

  #TODO Method to create a new snippet from a fork
  def self.create_fork_new(snippet, user)

  end
  
  # Find the snippets that share the tags of the snippet
  def get_similar_snippets(number)
    return self.similar_snippets.order('RANDOM()').first(number.to_i)
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
      tag = Tag.find_or_create_by(name: t.to_s)
      self.tags << tag
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

  # Find and update the boostrap version
  def get_bootstrap_version
    version = self.tags.where('is_bootstrap = ?', true)
    if version.nil? or version.empty?
    return
    else
      b = version.first.name
      v = Bootstrapversion.find_by(:name => b)
      if v
      self.bootstrapversion = v
      self.save
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
    self.update_column(:is_analysed => true)
  end


  private

  def generate_random_token
    require 'securerandom'
    random_string = SecureRandom.hex
    while(!Snippet.where(token: random_string).empty?)
      random_string = SecureRandom.hex
    end
    self.update_column(:token, random_string)
  end

end
