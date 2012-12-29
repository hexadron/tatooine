class FeedbacksController < ApplicationController

  before_filter :load_course
  before_filter :authenticate_user!, except: [:index]
  
  def index
    @feedback = Feedback.new
    load_feedbacks
    respond_with(@feedbacks) do |f|
      f.html do
        render layout: 'show_course'
      end
    end
  end

  def create
    @feedback = @course.feedbacks.build(params[:feedback])
    @feedback.user = current_user
    @feedback.save
    respond_with([@course, @feedback]) do |f|
      f.html do
        if errs = @feedback.errors and !errs.empty?
          flash[:alert] = format_errors(@feedback)
        end
        redirect_to course_feedbacks_url(@course)
      end
    end
  end
  
  private
  
  def load_course
    @course = Course.find(params[:course_id])
  end
  
  def load_feedbacks
    @feedbacks = @course.feedbacks
  end

end
