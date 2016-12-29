class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction



  def import
    if(params[:file])
      msg = Contract.import(params[:file])
      if(msg.to_s.empty?)
        redirect_to contracts_path, notice: "Import successful."
      else
        redirect_to contracts_path, flash: {:error=> msg}
      end
    else
      redirect_to index_path, flash: {:error=> "Oops, no CVS file specified."}
    end
  end

  # GET /contracts
  # GET /contracts.json
  def index

    #join to departments so we can sort on 'departments.name' Do the same for any other joined table (e.g. orgs)
    @contracts = Contract.filter(params.slice(:is_expired, :supplier_name, :organisation_name, :end_date_before, :product)).joins(:department).order(sort_column + ' '  + sort_direction)

    @total_count = @contracts.count
    @expired = @contracts.expired
    @total_count = @contracts.count
    @total_value = @contracts.pluck(:value_cents).reduce(:+).to_i/100
    @supplier_count = @contracts.pluck(:supplier_name).uniq.count
    @contracts = @contracts.page params[:page]
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)

    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    def sort_direction
      #whitelist options for security
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def sort_column
      #whitelist column names
      %w[supplier_name value_cents end_date departments.name].include?(params[:sort_column]) ? params[:sort_column].to_s : "reference"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contract).permit(:reference, :source, :department_id, :supplier_name, :value, :end_date, :organisation_id, :project, :product, :value_cents, :start_date, :years, :sector, :annual_value_cents, :category, :sub_contrators, :notes, :status, :year_awarded)
    end
end
