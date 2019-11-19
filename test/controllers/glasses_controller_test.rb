require 'test_helper'

class GlassesControllerTest < ActionController::TestCase
  setup do
    @glass = glasses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:glasses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create glass" do
    assert_difference('Glass.count') do
      post :create, glass: { name: @glass.name }
    end

    assert_redirected_to glass_path(assigns(:glass))
  end

  test "should show glass" do
    get :show, id: @glass
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @glass
    assert_response :success
  end

  test "should update glass" do
    patch :update, id: @glass, glass: { name: @glass.name }
    assert_redirected_to glass_path(assigns(:glass))
  end

  test "should destroy glass" do
    assert_difference('Glass.count', -1) do
      delete :destroy, id: @glass
    end

    assert_redirected_to glasses_path
  end
end
