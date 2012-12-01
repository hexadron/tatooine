class HomeController < ApplicationController
  def index
    if current_user
    else
      render layout: false
    end
  end

  def reset
    reset_session
    redirect_to root_path
  end
end
