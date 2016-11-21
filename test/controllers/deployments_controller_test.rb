require 'test_helper'

class DeploymentsControllerTest < ActionController::TestCase
  setup do
    @deployment = deployments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deployments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deployment" do
    assert_difference('Deployment.count') do
      post :create, deployment: { alternative_solution: @deployment.alternative_solution, benefit_type: @deployment.benefit_type, comments: @deployment.comments, cts_solution: @deployment.cts_solution, department_id: @deployment.department_id, existing_solution: @deployment.existing_solution, location: @deployment.location, organisation_id: @deployment.organisation_id, person_id: @deployment.person_id, portfolio_id: @deployment.portfolio_id, state: @deployment.state, tech_layer: @deployment.tech_layer }
    end

    assert_redirected_to deployment_path(assigns(:deployment))
  end

  test "should show deployment" do
    get :show, id: @deployment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deployment
    assert_response :success
  end

  test "should update deployment" do
    patch :update, id: @deployment, deployment: { alternative_solution: @deployment.alternative_solution, benefit_type: @deployment.benefit_type, comments: @deployment.comments, cts_solution: @deployment.cts_solution, department_id: @deployment.department_id, existing_solution: @deployment.existing_solution, location: @deployment.location, organisation_id: @deployment.organisation_id, person_id: @deployment.person_id, portfolio_id: @deployment.portfolio_id, state: @deployment.state, tech_layer: @deployment.tech_layer }
    assert_redirected_to deployment_path(assigns(:deployment))
  end

  test "should destroy deployment" do
    assert_difference('Deployment.count', -1) do
      delete :destroy, id: @deployment
    end

    assert_redirected_to deployments_path
  end
end
