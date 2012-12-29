# encoding: utf-8

class ExercisesController < ApplicationController
  
  respond_to :html, :js, :json, :xml
  
  before_filter :authenticate_user!
  before_filter :load_exercise, only: [:customize, :update, :destroy, :solve]
  
  def create
    load_section
    load_types_for_select

    @exercise = Exercise.new
    @exercise.section = @section
    @exercise.exercise_type = ExerciseType.first
    @exercise.save
    
    respond_with(@exercise)
  end
  
  def customize
    @exercise_type = @exercise.exercise_type
    @exercise.save
    respond_with(@exercise)
  end
  
  def update
    load_question_data
    
    # La pregunta sólo debe validarse cuando se "customiza" la pregunta.
    # Durante la creación (save) y carga con nuevo tipo (update) no
    # debe haber validación de la pregunta. Por ende, ésta sólo es validada
    # aquí, al no haber otro modo de distinguir entre un guardado
    # y una validación sin colocar campos distintivos en la base de datos.
    if @exercise.question.empty?
      flash[:alert] = "La pregunta no puede estar vacía"
    else
      @exercise.save
    end

    respond_with(@exercise)
  end
  
  def solve
    solution = params[:answer_data]
    
    @result = @exercise.solve_with(solution)
    @mistakes = @exercise.mistakes
    @invalidations = @exercise.invalidations
  end
  
  def destroy
    @exercise.destroy
    respond_with(@exercise)
  end
  
  private
  
  def load_section
    @section = Section.find(params[:section_id])
  end
  
  def load_exercise
    @exercise = Exercise.find(params[:id])
    if params[:exercise] and kind_id = params[:exercise][:exercise_type_id]
      @exercise.exercise_type_id = kind_id
      @exercise.load_context
    end
  end
  
  def load_question_data
    if @exercise
      @exercise.question = params[:exercise][:question]
      @exercise.define params[:question_data]
    end
  end
  
end