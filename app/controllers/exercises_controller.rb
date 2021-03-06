# encoding: utf-8
class ExercisesController < ApplicationController
  include CoursesProtector
  
  respond_to :html, :js, :json, :xml
  
  before_filter :authenticate_user!
  before_filter :load_exercise, only: [:customize, :update, :destroy, :solve]
  before_filter :protect_courses, only: [:create, :customize, :update, :destroy]
  
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
    r = current_user.solve(@exercise, params[:answer_data])
    
    @section = @exercise.section
    
    @ue = r[:ue]
    @us = r[:us]
    @result = r[:result]
    @mistakes = r[:mistakes]
    @invalidations = r[:invalidations]
    
    if not @result
      errors = @mistakes + @invalidations
      flash[:alert] = format_errors(errors)
      if errors.empty?
        flash[:alert] = "Respuesta incorrecta"
      end
    else
      news = ["Respuesta correcta"]
      badge_result = check_badges
      
      if badge_result[:result]
        news << "Además, has ganado la siguiente medalla: '#{badge_result[:badge].name}'"
      end
      
      if news.count > 1
        flash[:notice] = format_errors(news)
      else
        flash[:notice] = news.first
      end
    end
  end
  
  def destroy
    @exercise.destroy
    respond_with(@exercise)
  end
  
  private
  
  def check_badges
    @us.check_for_badges
  end
  
  def load_section
    @section ||= Section.find(params[:section_id])
  end
  
  def load_exercise
    @exercise = Exercise.find(params[:id])
    if params[:exercise] and kind_id = params[:exercise][:exercise_type_id]
      @exercise.exercise_type_id = kind_id
      @exercise.load_context
    end
  end
  
  def load_course
    exercises = Exercise.where(id: params[:id])
    if exercises.empty?
      load_section
      session = @section.course_session
    else
      section = exercises.first.section
      session = section.course_session
    end
    @course ||= session.course
  end
  
  def load_question_data
    if @exercise
      @exercise.question = params[:exercise][:question]
      @exercise.define params[:question_data]
    end
  end
  
end