# encoding: utf-8

require 'spec_helper'

describe ExerciseType do
  
  Exercise.new({value: "A", value: "B"})
  
  let(:exercise) { Exercise.new }
  
  let(:text_type) do
    ExerciseType.create({
      name: 'simple_text',
      implementor: ExerciseTypes::SimpleText
    })
  end
  
  let(:true_or_false_type) do
    ExerciseType.create({
      name: 'true_or_false',
      implementor: ExerciseTypes::TrueOrFalse
    })
  end
  
  let(:multiple_true_or_false_type) do
    ExerciseType.create({
      name: 'multiple_true_or_false',
      implementor: ExerciseTypes::MultipleTrueOrFalse
    })
  end
  
  let(:alternatives_type) do
    ExerciseType.create({
      name: 'alternatives',
      implementor: ExerciseTypes::Alternatives
    })
  end
  
  it 'should get the exercise types' do
    ExerciseType.create({
      name: 'simple_text',
      implementor: ExerciseTypes::SimpleText,
      active: true
    })
    
    ExerciseType.available_exercises.count.should be(1)
  end
  
  it 'should create one exercise type' do
    text_type.name  = "simple_text"
    text_type.implementor  = ExerciseTypes::SimpleText
    
    text_type.save
  end
  
  it "should create an exercise and get an empty partial" do
    exercise.exercise_type = text_type
    
    exercise.formatted_question.should_not == nil
  end
  
  it "should fill a simple_text exercise" do
    exercise.question = "¿En qué año comenzó la 2da guerra mundial?"
    exercise.exercise_type = text_type
    exercise.define :answer => "1939"
    
    exercise.solve_with(:answer => "1939").should be(true)
  end
  
  it "should fill a true_or_false exercise" do
    exercise.question = "¿Hitler murió en 1947?"
    exercise.exercise_type = true_or_false_type
    exercise.define :answer => false
    
    exercise.solve_with(:answer => true).should be(false)
  end
  
  it "should fill exercise with alternatives using a string" do
    exercise.question = "¿Quién escribió 'Cien Años de Soledad'?"
    exercise.exercise_type = alternatives_type
    exercise.define :alternatives => ["Mario Vargas Llosa", "Ernest Hemingway", "Gabriel García Marquez", "Gabriela Mistral", "Octavio Paz"], :answer => "Gabriel García Marquez"
    
    exercise.solve_with(:answer => "Gabriel García Marquez").should be(true)
  end

  it "should fill exercise with alternatives using an index integer" do
    exercise.question = "¿Con qué letra empieza la palabra 'Puerta' en inglés?"
    exercise.exercise_type = alternatives_type
    exercise.define :alternatives => ["A", "D", "M", "E", "F"], :answer => "D"
    
    exercise.solve_with(:answer => 1).should be(true)
  end
  
  it "should fill exercise with multiples T y F" do
    exercise.question = "Responde Verdadero o Falso según corresponda"
    exercise.exercise_type = multiple_true_or_false_type
    
    questions = [
      ["¿Hitler murió en 1949?", false],
      ["¿Hitler murió en 1948?", false],
      ["¿Hitler murió en 1947?", false],
      ["¿Hitler murió en 1945?", true],
      ["¿El amarillo es un color?", true]
    ]
    
    exercise.define :questions => questions
    
    answers = [false, false, false, true, true]
    
    exercise.solve_with(:answers => answers).should be(true)
  end
  
  it "should print the errors of a multiple true or false" do
    exercise.question = "Responde Verdadero o Falso según corresponda"
    exercise.exercise_type = multiple_true_or_false_type
    
    questions = [
      ["¿Hitler murió en 1949?", false],
      ["¿Hitler murió en 1948?", false],
      ["¿Hitler murió en 1947?", false],
      ["¿Hitler murió en 1945?", true],
      ["¿El amarillo es un color?", true]
    ]
    
    exercise.define :questions => questions
    
    answers = [false, true, false, true, true]
    
    exercise.solve_with(:answers => answers)
    
    exercise.mistakes.count.should == 1
  end
  
end
