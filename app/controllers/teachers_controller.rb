class TeachersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @my_teachers = current_user.teachers
    @teachers = User.teachers
  end

  def show
    @teacher = User.find params[:id]
    @courses = Course.availables.created_by(@teacher)
  end

end
