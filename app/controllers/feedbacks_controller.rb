class FeedbacksController < ApplicationController

  before_filter :load_course

  def create
    @feedback = @course.feedbacks.build(params[:feedback])
    @feedback.user = current_user
    @feedback.save
    respond_with([@course, @feedback]) do |f|
      f.html do
        redirect_to @course
      end
    end
  end
  
  private
  
  def load_course
    @course = Course.find(params[:course_id])
  end

end
