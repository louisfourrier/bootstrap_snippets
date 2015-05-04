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
#

require 'test_helper'

class SnippetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
