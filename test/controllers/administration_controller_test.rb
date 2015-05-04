require 'test_helper'

class AdministrationControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get waiting-snippets" do
    get :waiting-snippets
    assert_response :success
  end

end
