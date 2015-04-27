class BootstrapversionsController < ApplicationController
  before_action :set_bootstrapversion, only: [:show, :edit, :update, :destroy]
  before_filter :is_administrator?
  # GET /bootstrapversions
  # GET /bootstrapversions.json
  def index
    @bootstrapversions = Bootstrapversion.all
  end

  # GET /bootstrapversions/1
  # GET /bootstrapversions/1.json
  def show
  end

  # GET /bootstrapversions/new
  def new
    @bootstrapversion = Bootstrapversion.new
  end

  # GET /bootstrapversions/1/edit
  def edit
  end

  # POST /bootstrapversions
  # POST /bootstrapversions.json
  def create
    @bootstrapversion = Bootstrapversion.new(bootstrapversion_params)

    respond_to do |format|
      if @bootstrapversion.save
        format.html { redirect_to @bootstrapversion, notice: 'Bootstrapversion was successfully created.' }
        format.json { render :show, status: :created, location: @bootstrapversion }
      else
        format.html { render :new }
        format.json { render json: @bootstrapversion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bootstrapversions/1
  # PATCH/PUT /bootstrapversions/1.json
  def update
    respond_to do |format|
      if @bootstrapversion.update(bootstrapversion_params)
        format.html { redirect_to @bootstrapversion, notice: 'Bootstrapversion was successfully updated.' }
        format.json { render :show, status: :ok, location: @bootstrapversion }
      else
        format.html { render :edit }
        format.json { render json: @bootstrapversion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bootstrapversions/1
  # DELETE /bootstrapversions/1.json
  def destroy
    @bootstrapversion.destroy
    respond_to do |format|
      format.html { redirect_to bootstrapversions_url, notice: 'Bootstrapversion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bootstrapversion
      @bootstrapversion = Bootstrapversion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bootstrapversion_params
      params.require(:bootstrapversion).permit(:name, :url_name)
    end
end
