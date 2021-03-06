# encoding: utf-8
class CoursesController < ApplicationController
  include CoursesProtector
  
  before_filter :authenticate_user!, except: [:show, :faq]
  before_filter :load_course, except: [:index, :new, :create]
  before_filter :load_courses, only: [:index]
  before_filter :reject_unpublished_courses, only: [:show, :faq, :stats, :ranking]
  
  before_filter :protect_courses, only: [:edit, :update, :destroy, :stats]

  def index
    @levels = Level.select([:name]).map(&:name)
    
    if @search
      original_source = @courses
      
      @available_courses = original_source.availables.to_a
      @courses = original_source.to_a # fetch the query
      
      @your_level_courses = Course.with_level(current_user.average_level, {array: @available_courses})
      @courses_you_created = Course.created_by(current_user, {array: @courses})
      @courses_you_take = Course.taken_by(current_user, {array: @available_courses})
      
      @courses = original_source.availables
    else
      @your_level_courses = @courses.availables.with_level(current_user.average_level)
      @courses_you_created = @courses.created_by(current_user)
      @courses_you_take = @courses.availables.taken_by(current_user)
      
      @courses = @courses.availables
    end
  end
  
  def show
    @classes = @course.course_sessions
    
    respond_with(@course) do |format|
      format.html do
        render layout: 'show_course'
      end
    end
  end
  
  def edit
    if current_user.creations.include? @course
      respond_with(@course) do |format|
        format.html do
          render layout: 'edit_course'
        end
      end
    else
      redirect_to course_path(@course)
    end
  end
  
  def new
    @course = Course.new
    respond_with(@course)
  end
  
  def destroy
    @course = Course.find params[:id]
    @course.destroy
    redirect_to courses_path
  end
  
  def create
    @course = Course.new(params[:course])
    @course.creator = current_user
    @course.level_id = params[:course][:level_id]
    @course.save
    respond_with(@course) do |format|
      format.html do
        if @course.errors.empty?
          flash[:notice] = "¡Curso creado exitosamente!"
          redirect_to(edit_course_url(@course))
        else
          render :new
        end
      end
    end
  end
  
  def update
    @course.update_attributes(params[:course])
    respond_with(@course) do |format|
      format.html do
        if @course.errors.empty?
          flash[:notice] = "¡Curso actualizado exitosamente!"
          redirect_to(edit_course_url(@course))
        else
          flash[:alert] = format_errors(@course)
          redirect_to(edit_course_url(@course))
        end
      end
    end
  end
  
  def enroll
    enrollment = @course.add_student(current_user)
    if enrollment.errors.any?
      flash[:alert] = format_errors(enrollment)
    else
      flash[:notice] = "Has sido registrado en este curso"
    end
    redirect_to(@course)
  end
  
  def faq
    render layout: 'show_course'
  end
  
  def stats
    @ranking = @course.ranking
    @sessions = @course.course_sessions
    render layout: 'show_course'
  end
  
  def ranking
    @ranking = @course.ranking
    render layout: 'show_course'
  end
  
  private
  
  def load_courses
    @q = Course.search(params[:q])
    @search = !!params[:q]
    
    @courses = if params[:q]
      @q.result(distinct: true).joins("left join enrollments on enrollments.course_id = courses.id").joins(:level).select("courses.*, enrollments.user_id as enrollment_user_id, levels.name as level_name")
    else
      Course.where("1 = 1")
    end
  end
  
  def load_course
    @course = @course || Course.find(params[:id])
    @enrolled = if current_user
      current_user.courses.include?(@course)
    else
      false
    end
  end
  
  def reject_unpublished_courses
    load_course
    unless @course.available?
      redirect_to '/404.html'
    end
  end
  
end