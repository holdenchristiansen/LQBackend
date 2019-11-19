require 'test_helper'

class GarnishesControllerTest < ActionController::TestCase
  setup do
    @garnish = garnishes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:garnishes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create garnish" do
    assert_difference('Garnish.count') do
      post :create, garnish: { name: @garnish.name }
    end

    assert_redirected_to garnish_path(assigns(:garnish))
  end

  test "should show garnish" do
    get :show, id: @garnish
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @garnish
    assert_response :success
  end

  test "should update garnish" do
    patch :update, id: @garnish, garnish: { name: @garnish.name }
    assert_redirected_to garnish_path(assigns(:garnish))
  end

  test "should destroy garnish" do
    assert_difference('Garnish.count', -1) do
      delete :destroy, id: @garnish
    end

    assert_redirected_to garnishes_path
  end
end
