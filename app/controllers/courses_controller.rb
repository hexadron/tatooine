class CoursesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :protect_courses, only: [:edit, :update, :delete]
  before_filter :find_course, only: [:delete, :update, :edit, :show, :enroll]

  def index
    @your_level_courses = Course.with_level(current_user.average_level)
    @courses_you_created = current_user.creations
    @courses_you_take = current_user.courses
    @courses = Course.all
    #This is required by formtastic to bind values in search form ;)
    @search = Course.new
  end

  def search
    #TODO: Eemm... ayuda recuperando los datos :D.
    @courses_filtered = Course.all

  end
  
  def show
    respond_with(@course)
  end
  
  def edit
    if current_user.creations.include? @course
      respond_with(@course)
    else
      redirect_to course_path(@course)
    end
  end
  
  def new
    @course = Course.new
    load_defaults
  end
  
  def destroy
    @course = Course.find params[:id]
    @course.destroy
    redirect_to courses_path
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