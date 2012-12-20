class ExercisesController < ApplicationController
  
  respond_to :html, :js, :json, :xml
  
  def create
    load_section
    
    @exercise = Exercise.new
    @exercise.section = @section
    @exercise.exercise_type = ExerciseType.first
    @exercise.save
    respond_with(@exercise)
  end
  
  def customize
    load_exercise
    @exercise.update_attributes!(params[:exercise])
    @exercise_type = @exercise.exercise_type
    respond_with(@exercise)
  end
  
  def destroy
    load_exercise
    @exercise.destroy
    respond_with(@exercise)
  end
  
  private
  
  def load_section
    @section = Section.find(params[:section_id])
  end
  
  def load_exercise
    @exercise = Exercise.find(params[:id])
  end
  
end