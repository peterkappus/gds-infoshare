require 'test_helper'

class BenefitYearsControllerTest < ActionController::TestCase
  setup do
    @benefit_year = benefit_years(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:benefit_years)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create benefit_year" do
    assert_difference('BenefitYear.count') do
      post :create, benefit_year: { benefit_id: @benefit_year.benefit_id, fy_end_date: @benefit_year.fy_end_date, target_amount: @benefit_year.target_amount }
    end

    assert_redirected_to benefit_year_path(assigns(:benefit_year))
  end

  test "should show benefit_year" do
    get :show, id: @benefit_year
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @benefit_year
    assert_response :success
  end

  test "should update benefit_year" do
    patch :update, id: @benefit_year, benefit_year: { benefit_id: @benefit_year.benefit_id, fy_end_date: @benefit_year.fy_end_date, target_amount: @benefit_year.target_amount }
    assert_redirected_to benefit_year_path(assigns(:benefit_year))
  end

  test "should destroy benefit_year" do
    assert_difference('BenefitYear.count', -1) do
      delete :destroy, id: @benefit_year
    end

    assert_redirected_to benefit_years_path
  end
end
