class HomeController < ApplicationController
  def index
    render layout: false
  end

  def reset
    reset_session
    redirect_to root_path
  end
end
