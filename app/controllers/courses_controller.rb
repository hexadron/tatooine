class CoursesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :protect_courses, only: [:edit, :update, :delete]
  before_filter :find_course, only: [:delete, :update, :edit, :show, :enroll]
  before_filter :load_courses, only: [:index]

  def index
    # OPTIMIZE
    @levels = Level.select([:name]).map(&:name)
    
    if @search
      @courses = @courses.to_a # fetch the query
      @your_level_courses = Course.with_level(current_user.average_level, {array: @courses})
      @courses_you_created = Course.created_by(current_user, {array: @courses})
      @courses_you_take = Course.taken_by(current_user, {array: @courses})
    else
      @your_level_courses = @courses.with_level(current_user.average_level)
      @courses_you_created = @courses.created_by(current_user)
      @courses_you_take = @courses.taken_by(current_user)
    end
  end
  
  def show
    @feedbacks = @course.feedbacks
    @feedback = Feedback.new
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
  
  def load_courses
    @q = Course.search(params[:q])
    @search = !!params[:q]
    
    @courses = if params[:q]
      @q.result(distinct: true).joins(:enrollments, :level).select("courses.*, enrollments.user_id as enrollment_user_id, levels.name as level_name")
    else
      Course.where("1 = 1")
    end
  end
  
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