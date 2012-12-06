# encoding: utf-8

require 'spec_helper'

describe Exercise do
  
  let(:text_type) do
    ExerciseType.create({
      name: 'simple_text',
      implementor: ExerciseTypes::SimpleText
    })
  end
  
  # it "should create an exercise" do
    # exercise = Exercise.new
    # exercise.exercise_type = text_type
    # exercise.question = "¿Quién descubrió América?"
    
    # formulario
    # - combobox con los tipos de ejercicios
    #   - al seleccionar, mostrar el partial correspondiente
    #     usando exercise_type.formatted_question como partial
    #     form as f.
    # - caja de texto para question
    # Toda la data del formulario del partial es serializada del
    # hash a un json. Esta data será deserializado al generar el ejercicio.
  # end
  
end
