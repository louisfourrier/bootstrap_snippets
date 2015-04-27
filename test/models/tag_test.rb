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

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
