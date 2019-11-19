require 'test_helper'

class RecipesStepsControllerTest < ActionController::TestCase
  setup do
    @recipes_step = recipes_steps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes_steps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipes_step" do
    assert_difference('RecipesStep.count') do
      post :create, recipes_step: { recipe: @recipes_step.recipe, stepamount: @recipes_step.stepamount, stepindex: @recipes_step.stepindex, steptitle: @recipes_step.steptitle }
    end

    assert_redirected_to recipes_step_path(assigns(:recipes_step))
  end

  test "should show recipes_step" do
    get :show, id: @recipes_step
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipes_step
    assert_response :success
  end

  test "should update recipes_step" do
    patch :update, id: @recipes_step, recipes_step: { recipe: @recipes_step.recipe, stepamount: @recipes_step.stepamount, stepindex: @recipes_step.stepindex, steptitle: @recipes_step.steptitle }
    assert_redirected_to recipes_step_path(assigns(:recipes_step))
  end

  test "should destroy recipes_step" do
    assert_difference('RecipesStep.count', -1) do
      delete :destroy, id: @recipes_step
    end

    assert_redirected_to recipes_steps_path
  end
end
