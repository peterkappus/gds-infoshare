class BenefitYearsController < ApplicationController
  before_action :set_benefit_year, only: [:show, :edit, :update, :destroy]

  # GET /benefit_years
  # GET /benefit_years.json
  def index
    @benefit_years = BenefitYear.all
  end

  # GET /benefit_years/1
  # GET /benefit_years/1.json
  def show
  end

  # GET /benefit_years/new
  def new
    @benefit_year = BenefitYear.new
  end

  # GET /benefit_years/1/edit
  def edit
  end

  # POST /benefit_years
  # POST /benefit_years.json
  def create
    @benefit_year = BenefitYear.new(benefit_year_params)

    respond_to do |format|
      if @benefit_year.save
        format.html { redirect_to @benefit_year, notice: 'Benefit year was successfully created.' }
        format.json { render :show, status: :created, location: @benefit_year }
      else
        format.html { render :new }
        format.json { render json: @benefit_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /benefit_years/1
  # PATCH/PUT /benefit_years/1.json
  def update
    respond_to do |format|
      if @benefit_year.update(benefit_year_params)
        format.html { redirect_to @benefit_year, notice: 'Benefit year was successfully updated.' }
        format.json { render :show, status: :ok, location: @benefit_year }
      else
        format.html { render :edit }
        format.json { render json: @benefit_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /benefit_years/1
  # DELETE /benefit_years/1.json
  def destroy
    @benefit_year.destroy
    respond_to do |format|
      format.html { redirect_to benefit_years_url, notice: 'Benefit year was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_benefit_year
      @benefit_year = BenefitYear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benefit_year_params
      params.require(:benefit_year).permit(:fy_end_date, :target_amount, :benefit_id)
    end
end
