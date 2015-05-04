class AdministrationController < ApplicationController
  before_action :is_administrator?
  
  def home
  end

  def waiting_snippets
    @snippets = Snippet.waiting.paginate(:page => params[:page], :per_page => 20)
  end
  
  
end
