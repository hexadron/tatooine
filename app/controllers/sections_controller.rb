class SectionsController < ApplicationController
  
  before_filter :load_session_and_course
  before_filter :load_section, only: [:show, :edit, :update, :destroy]
  
  layout 'edit_session'
  
  def index
    
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