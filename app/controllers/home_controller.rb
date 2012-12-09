class HomeController < ApplicationController
  def index
    if current_user
      @courses = Course.all
      @teachers = User.teachers
    else
      render 'login'
    end
  end

  def reset
    reset_session
    redirect_to root_path
  end
end
