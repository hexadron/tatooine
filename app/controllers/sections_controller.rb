# encoding: utf-8

class SectionsController < ApplicationController
  
  before_filter :load_session_and_course
  before_filter :load_section, only: [:show, :edit, :update, :destroy]
  
  layout 'edit_session'
  
  def index
    @sections = @session.sections
    @section = Section.new
    respond_with(@course, @session, @sections)
  end
  
  def create
    @section = Section.new(params[:section])
    @section.course_session = @session
    @section.save
    
    respond_with(@section) do |format|
      format.html do
        flash[:notice] = 'Nueva Sección Creada'
        redirect_to course_course_session_sections_url
      end
    end
  end
  
  private
  
  def load_session_and_course
    @course ||= Course.find(params[:course_id])
    @session ||= CourseSession.find(params[:course_session_id])
  end
  
  def load_section
    load_session_and_course
    @section ||= Section.find(params[:id])
  end
end