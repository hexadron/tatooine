# encoding: utf-8

class CourseSessionsController < ApplicationController
  include CoursesProtector
  
  before_filter :authenticate_user!, except: [:show]
  before_filter :load_course, except: [:resort]
  before_filter :load_session, only: [:show, :edit, :update, :destroy]
  before_filter :protect_courses, only: [:index, :edit, :update, :destroy, :new, :create, :resort]
  
  layout 'edit_course'
    
  def index
    @course_sessions = @course.course_sessions.order(:created_at)
  end
  
  def show
    @sections = @session.sections.order(:position)
    respond_with(@session) do |f|
      f.html {
        render layout: 'show_course'
      }
    end
  end
  
  def edit
    render layout: 'edit_session'
  end
  
  def update
    @session.update_attributes(params[:course_session])
    if @session.errors.empty?
      flash[:notice] = "¡Curso actualizado exitosamente!"
      redirect_to edit_course_course_session_url(@course, @session)
    else
      flash[:alert] = format_errors(@session)
      redirect_to edit_course_course_session_url(@course, @session)
    end
  end
  
  def new
    @session = CourseSession.new
  end
  
  def create
    @session = CourseSession.new(params[:course_session])
    @session.course = @course
    @session.save
    respond_with(@session) do |format|
      format.html do
        if @session.errors.empty?
          redirect_to edit_course_course_session_url(@course, @session)
        else
          render :new
        end
      end
    end
  end
  
  def destroy
    @session.destroy
    flash[:notice] = "Clase eliminada correctamente"
    respond_with(@session) do |format|
      format.html do
        redirect_to course_course_sessions_url(@course)
      end
    end
  end
  
  def resort
    ids = params[:sections]
    ids.each_with_index do |id, idx|
      Section.update(id, position: idx)
    end
    render nothing: true
  end
  
  private
  
  def load_session
    load_course
    @session = CourseSession.find(params[:id])
  end
  
  def load_course
    @course = Course.find(params[:course_id])
    @enrolled = if current_user
      current_user.courses.include?(@course)
    else
      false
    end
  end
  
end
