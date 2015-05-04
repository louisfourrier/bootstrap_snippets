class SnippetsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create, :user_status, :admin_status, :fork_snippet]
  before_action :set_snippet, only: [:show, :edit, :update, :destroy, :iframe, :user_status, :admin_status, :favorite, :fork_snippet]
  before_action :correct_user, only: [:edit, :update, :destroy, :user_status]
  before_action :is_administrator?, only: [:admin_status]
  # GET /snippets
  # GET /snippets.json
  def index
    @snippets = Snippet.approved.includes(:tags).paginate(:page => params[:page], :per_page => 20)

    letter = params[:starting_letter]
    if !letter.nil?
      @letter = I18n.transliterate(letter.to_s.strip.downcase).to_s
      @snippets = Snippet.approved.where('snippets.title ilike ? OR snippets.research_name ilike ?', "%#{@letter}%", "%#{@letter}%").includes(:tags).paginate(:page => params[:page], :per_page => 20)
    else
      @snippets = Snippet.approved.includes(:tags).paginate(:page => params[:page], :per_page => 20)
    end
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    @tags = @snippet.tags
    # Increment the counter of the ciews for the snippet
    @snippet.increment!(:views_count)
  end

  def iframe
    render :layout => false
  end

  # This action is a redirection after creating a new instance in the DB
  def new
    @snippet = Snippet.create_new(current_user)
    redirect_to edit_snippet_path(@snippet)
  end

  # GET /snippets/1/edit
  def edit
  end

  # POST /snippets
  # POST /snippets.json
  def create
    @snippet = Snippet.new(snippet_params)

    respond_to do |format|
      if @snippet.save
        format.html { redirect_to @snippet, notice: 'Snippet was successfully created.' }
        format.json { render :show, status: :created, location: @snippet }
      else
        format.html { render :new }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snippets/1
  # PATCH/PUT /snippets/1.json
  def update
    respond_to do |format|
      if @snippet.update(snippet_params)
        @success = true
        format.html { redirect_to @snippet, notice: 'Snippet was successfully updated.' }
        format.json { render :show, status: :ok, location: @snippet }
      format.js
      else
        @success = false
        format.html { render :edit }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      format.js
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    @snippet.destroy
    respond_to do |format|
      format.html { redirect_to profile_user_path(current_user), notice: 'Snippet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_status
    status = params[:status].to_s.to_i
    current_status = @snippet.user_status_update(status)
    respond_to do |format|
      @message = "The Status of the Snippet has now changed to " + current_status
      format.js { render "/layouts/message" }
    end
  end
  
  # Route to put the snippet in the favorite of the user
  def favorite
    if signed_in?
      message = @snippet.favorite_from(current_user)
      redirect_to @snippet, notice: message.to_s
      return
    else
      redirect_to @snippet, notice: "You must be logged in to perform this action"
      return
    end
  end
  
  # Create a new Snippet from a fork and redirect to the newly created one
  def fork_snippet
    new_snippet = @snippet.create_fork_new(current_user)
    redirect_to edit_snippet_path(new_snippet), notice: "Your new Snippet from the fork"
  end

  def admin_status
    status = params[:status].to_s.to_i
    message = @snippet.admin_status_update(status)
    respond_to do |format|
      format.html {redirect_to @snippet, notice: "The status is now : " + message.to_s }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_snippet
    @snippet = Snippet.find(params[:id])
  end

  # Check if this is the good user
  def correct_user
    if current_user.nil?
      redirect_to new_user_session_path, notice: 'You must be log in to perform this action'
    return
    else
      if @snippet.user == current_user || current_user.is_administrator
      return
      else
        redirect_to snippets_url,  notice: 'Not authorized to perform this action'
      return
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def snippet_params
    params.require(:snippet).permit(:bootstrap_version, :tags_list, :title, :slug, :image_url, :original_url, :html_content, :html_code, :css_code, :js_code, :description, :user_id)
  end
end
