class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :profile]
  before_action :correct_user, except: [:show]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @snippets = @user.snippets.approved.paginate(:page => params[:page], :per_page => 20)
  end
  
  # Profile page of the user with the snippets
  def profile
    @snippets = @user.snippets.paginate(:page => params[:page], :per_page => 20)
    @favorite_snippets = @user.favorite_snippets.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end
    
    def correct_user
      if signed_in?
        if current_user == @user || is_administrator
          return
        else
          redirect_to root_path, notice: "You are not allowed to access this page"
          return
        end
      else
        redirect_to new_user_session_path, notice: 'You must be log in to perform this action'
        return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end
