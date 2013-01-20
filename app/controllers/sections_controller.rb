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
    load_attachments
    load_types_for_select
    load_badge
    respond_with(@course, @session, @section, @attachment)
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
    load_badge
    render :show
  end
  
  def destroy
    @section.destroy
    flash[:notice] = "Sección eliminada exitosamente"
    redirect_to course_course_session_sections_url
  end



  
  private
  
  def load_badge
    @section_badge = Badge.for(@course, "sections::complete", section_id: @section.id)
  end
  
  def load_attachments
    @attachments = @section.attachments
  end
  
  def load_exercises
    @exercises = @section.exercises
  end
  
  def load_course
    @course ||= Course.find(params[:course_id]) if params[:course_id]
  end
  
  def load_session_and_course
    load_course
    @session ||= CourseSession.find(params[:course_session_id]) if params[:course_session_id]
  end
  
  def load_section
    load_session_and_course
    @section ||= Section.find(params[:id]) if params[:id]
  end
end