class StudentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @my_students = current_user.students
  end

  def show
    @student = User.find params[:id]
    @courses = Course.availables.taken_by(@student)
  end

end
