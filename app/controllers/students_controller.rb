class StudentsController < ApplicationController

  def index
    @my_students = current_user.students
  end

  def show
    @student = User.find params[:id]
    @courses = @student.courses
  end

end
