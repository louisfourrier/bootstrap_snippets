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

require 'test_helper'

class BootstrapversionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
