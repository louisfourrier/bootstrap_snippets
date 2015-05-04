class BootstrapversionsController < ApplicationController
  before_action :is_administrator?, except: [:index, :show]
  before_action :set_bootstrapversion, only: [:show, :edit, :update, :destroy]
  
  def index
    @bootstrapversions = Bootstrapversion.all
  end

  def show
    @snippets = @bootstrapversion.snippets.approved.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @bootstrapversion = Bootstrapversion.new
  end

  def edit
  end

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
