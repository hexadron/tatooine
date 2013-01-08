# encoding: utf-8
class SectionsController < ApplicationController
  include CoursesProtector
  
  respond_to :html, :js, :json, :xml
  
  before_filter :authenticate_user!
  before_filter :load_session_and_course
  before_filter :load_section, only: [:show, :edit, :update, :destroy]
  
  before_filter :protect_courses
  
  layout 'edit_session'
  
  def show
    load_exercises
    load_types_for_select
    respond_with(@course, @session, @section)
  end
  
  def index
    @sections = @session.sections.order(:position)
    @section = Section.new
    respond_with(@course, @session, @sections)
  end
  
  def create
    @section = Section.new(params[:section])
    @section.course_session = @session
    @section.save
    
    respond_with(@section) do |format|
      format.html do
        if @section.errors.empty?
          flash[:notice] = 'Nueva Sección Creada'
          redirect_to course_course_session_sections_url
        else
          flash[:alert] = format_errors(@section)
          redirect_to course_course_session_sections_url
        end
      end
    end
  end
  
  def update
    @section.update_attributes(params[:section])
    if @section.errors.empty?
      flash[:notice] = "Contenido Actualizado"
      @success = true
    else
      flash[:alert] = format_errors(@section)
      @success = false
    end
    load_exercises
    render :show
  end
  
  private
  
  def load_exercises
    @exercises = @section.exercises
  end
  
  def load_course
    @course ||= Course.find(params[:course_id])
  end
  
  def load_session_and_course
    load_course
    @session ||= CourseSession.find(params[:course_session_id])
  end
  
  def load_section
    load_session_and_course
    @section ||= Section.find(params[:id])
  end
end