require 'test_helper'

class ContractsControllerTest < ActionController::TestCase
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post :create, contract: { annual_value_cents: @contract.annual_value_cents, category: @contract.category, department_id: @contract.department_id, end_date: @contract.end_date, notes: @contract.notes, organisation_id: @contract.organisation_id, product: @contract.product, project: @contract.project, reference: @contract.reference, sector: @contract.sector, source: @contract.source, start_date: @contract.start_date, status: @contract.status, sub_contractors: @contract.sub_contractors, supplier_name: @contract.supplier_name, value: @contract.value, value_cents: @contract.value_cents, year_awarded: @contract.year_awarded, years: @contract.years }
    end

    assert_redirected_to contract_path(assigns(:contract))
  end

  test "should show contract" do
    get :show, id: @contract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contract
    assert_response :success
  end

  test "should update contract" do
    patch :update, id: @contract, contract: { annual_value_cents: @contract.annual_value_cents, category: @contract.category, department_id: @contract.department_id, end_date: @contract.end_date, notes: @contract.notes, organisation_id: @contract.organisation_id, product: @contract.product, project: @contract.project, reference: @contract.reference, sector: @contract.sector, source: @contract.source, start_date: @contract.start_date, status: @contract.status, sub_contractors: @contract.sub_contractors, supplier_name: @contract.supplier_name, value: @contract.value, value_cents: @contract.value_cents, year_awarded: @contract.year_awarded, years: @contract.years }
    assert_redirected_to contract_path(assigns(:contract))
  end

  test "should destroy contract" do
    assert_difference('Contract.count', -1) do
      delete :destroy, id: @contract
    end

    assert_redirected_to contracts_path
  end
end
