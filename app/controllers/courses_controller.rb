# encoding: utf-8
class CoursesController < ApplicationController
  
  before_filter :authenticate_user!, except: [:show, :faq]
  before_filter :protect_courses, only: [:edit, :update, :delete]
  before_filter :find_course, only: [:delete, :update, :edit, :show, :enroll, :faq]
  before_filter :load_courses, only: [:index]
  before_filter :reject_unpublished_courses, only: [:show, :faq]

  def index
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
    @course.add_student(current_user)
    flash[:notice] = "Has sido registrado en este curso"
    redirect_to(@course)
  end
  
  def faq
    respond_with(@course) do |format|
      format.html do
        render layout: 'show_course'
      end
    end
  end
  
  private
  
  def load_courses
    @q = Course.search(params[:q])
    @search = !!params[:q]
    
    @courses = if params[:q]
      @q.result(distinct: true).joins("left join enrollments on enrollments.course_id = courses.id").joins(:level).select("courses.*, enrollments.user_id as enrollment_user_id, levels.name as level_name").availables
    else
      Course.where("1 = 1").availables
    end
  end
  
  def find_course
    @course = @course || Course.find(params[:id])
  end
  
  def protect_courses
    find_course
    if @course.creator != current_user
      redirect_to '/404.html'
    end
  end
  
  def reject_unpublished_courses
    find_course
    unless @course.available?
      redirect_to '/404.html'
    end
  end
  
end