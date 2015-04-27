require 'test_helper'

class BootstrapversionsControllerTest < ActionController::TestCase
  setup do
    @bootstrapversion = bootstrapversions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bootstrapversions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bootstrapversion" do
    assert_difference('Bootstrapversion.count') do
      post :create, bootstrapversion: { name: @bootstrapversion.name, url_name: @bootstrapversion.url_name }
    end

    assert_redirected_to bootstrapversion_path(assigns(:bootstrapversion))
  end

  test "should show bootstrapversion" do
    get :show, id: @bootstrapversion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bootstrapversion
    assert_response :success
  end

  test "should update bootstrapversion" do
    patch :update, id: @bootstrapversion, bootstrapversion: { name: @bootstrapversion.name, url_name: @bootstrapversion.url_name }
    assert_redirected_to bootstrapversion_path(assigns(:bootstrapversion))
  end

  test "should destroy bootstrapversion" do
    assert_difference('Bootstrapversion.count', -1) do
      delete :destroy, id: @bootstrapversion
    end

    assert_redirected_to bootstrapversions_path
  end
end
