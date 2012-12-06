class HomeController < ApplicationController
  def index
    
  end

  def reset
    reset_session
    redirect_to root_path
  end
end
