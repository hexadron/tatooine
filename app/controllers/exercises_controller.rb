# encoding: utf-8
require 'ostruct'

class ExercisesController < ApplicationController
  
  respond_to :html, :js, :json, :xml
  
  def create
    load_section
    
    @exercise = Exercise.new
    @exercise.section = @section
    @exercise.exercise_type_id = ExerciseType.first
    @exercise.save
    
    respond_with(@exercise)
  end
  
  def customize
    load_exercise
    
    @exercise.exercise_type_id = params[:exercise][:exercise_type_id]
    @exercise_type = @exercise.exercise_type
    
    @exercise.load_context
    @exercise.question_data = hash_to_struct(@exercise.context)
    
    respond_with(@exercise)
  end
  
  def update
    load_exercise
    
    @exercise.question = params[:exercise][:question]
    @exercise.define params[:question_data]
    
    if @exercise.question.empty?
      flash[:alert] = "La pregunta no puede estar vacía"
    else
      @exercise.sync_definitions      
      @exercise.save
    end

    respond_with(@exercise)
  end
  
  def destroy
    load_exercise
    @exercise.destroy
    
    respond_with(@exercise)
  end
  
  private
  
  def hash_to_struct(hash)
    o = OpenStruct.new
    hash.each do |k, v|
      o.send("#{k}=", v)
    end
    o
  end
  
  def load_section
    @section = Section.find(params[:section_id])
  end
  
  def load_exercise
    @exercise = Exercise.find(params[:id])
  end
  
end