class HomeController < ApplicationController
  def index
    if current_user
      @courses = Course.availables
      @teachers = User.teachers
    else
      load_featured_courses
      render 'login'
    end
  end

  def reset
    reset_session
    redirect_to root_path
  end
  
  private
  
  def load_featured_courses
    # Cambiar esto por algo más inteligente. Sólo estoy haciendo la implementación más simple.
    @featured_courses = Course.availables
  end
end
