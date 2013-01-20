# encoding: utf-8

class AttachmentsController < ApplicationController
  include CoursesProtector

  before_filter :load_attachment, only: [:destroy, :update]
  before_filter :authenticate_user!, except: [:index]
  before_filter :protect_courses, only: [:new, :create, :edit, :update, :destroy]
  
  def create
    load_section

    @attachment = Attachment.new
    @attachment.section = @section
    @attachment.save
  end
  
  def destroy
    @attachment.destroy
  end
  
  def update
    @attachment.displayable = true
    @attachment.update_attributes(params[:attachment])
    if @attachment.errors.count > 0
      flash[:alert] = format_errors(@attachment)
    else
      flash[:notice] = "Adjunto guardado correctamente"
    end
    
    respond_with(@section, @attachment) do |f|
      f.html {
        load_course
        redirect_to course_course_session_sections_url(@course, @session)
      }
      
    end
  end
  
  private
  
  def load_attachment
    @attachment ||= Attachment.find(params[:id])
  end
  
  def load_section
    @section ||= Section.find(params[:section_id])
  end
  
  def load_course
    attachments = Attachment.where(id: params[:id])
    if attachments.empty?
      load_section
      @session ||= @section.course_session
    else
      section = attachments.first.section
      @session ||= section.course_session
    end
    @course ||= @session.course
  end

end
