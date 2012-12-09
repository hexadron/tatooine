class CoursesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :protect_courses, only: [:edit, :update, :delete]
  before_filter :find_course, only: [:delete, :update, :edit, :show, :enroll]

  def index
    @your_level_courses = Course.with_level(current_user.average_level)
    @courses_you_created = current_user.creations
    @courses_you_take = current_user.courses
  end
  
  def show
    respond_with(@course)
  end
  
  def edit
    respond_with(@course)
  end
  
  def new
    @course = Course.new
    load_defaults
  end
  
  def delete
    @course.destroy
    respond_with(@course)
  end
  
  def create
    @course = Course.new(params[:course])
    @course.creator = current_user
    @course.save
    respond_with(@course)
  end
  
  def update
    @course.update_attributes(params[:course])
    respond_with(@course)
  end
  
  def enroll
    @course.add_student(current_user)
    flash[:notice] = "You have enrolled to this course :)"
    redirect_to(@course)
  end
  
  private
  
  def load_defaults
    @course.load_defaults!
  end
  
  def find_course
    @course ||= Course.find(params[:id])
  end
  
  def protect_courses
    find_course
    @course.creator == current_user
  end
  
end