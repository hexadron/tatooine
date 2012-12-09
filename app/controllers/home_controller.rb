class HomeController < ApplicationController
  def index
    render 'login' unless current_user
  end

  def reset
    reset_session
    redirect_to root_path
  end
end
