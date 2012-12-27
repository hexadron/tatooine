class ExerciseType < ActiveRecord::Base
  attr_accessible :name, :active, :kind, :implementor
  attr_accessor :implementor, :implementor_instance, :active
  
  before_save :transform_implementor_to_kind
  before_save :activate
  
  class << self
    def available_exercises
      self.where active: [true, nil]
    end
  end
  
  def implementor
    if @implementor
      @implementor
    else
      begin
        kind.constantize
      rescue => e
        nil
      end
    end
  end
  
  def implementor=(value)
    @implementor = value
    @implementor_instance = value.new
    @implementor
  end
  
  def update_implementor!
    @implementor_instance = implementor.new if @implementor_instance.nil?
  end
  
  def question_partial
    if implementor
      File.join("exercise_types", "#{underscored_simple_class_name}_question")
    end
  end
  
  def answer_partial
    if implementor
      File.join("exercise_types", "#{underscored_simple_class_name}_answer")
    end
  end
  
  private
  
  def underscored_simple_class_name
    implementor.name.gsub(/^.*::/,'').underscore
  end
  
  def transform_implementor_to_kind
    if implementor
      self.kind = implementor.name
    end
  end
  
  def activate
    self.active = true if self.active.nil?
    self.active
    true
  end
end