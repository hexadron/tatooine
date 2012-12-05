class Exercise < ActiveRecord::Base
  belongs_to :exercise_type
  belongs_to :evaluation
  attr_accessible :question, :result
  
  attr_accessor :context, :solver
  
  after_initialize :create_context
  
  def formatted_question(type="html")
    if type.to_s == "html"
      exercise_type.creator
    end
  end
  
  def define(definitions)
    if exercise_type
      definitions.each do |k, v|
        self.context[k] = v
      end
    end
  end
  
  def create_context
    self.context = Hash.new
  end
  
  def mistakes
    if @solver and errors = @solver.errors
      errors
    else
      []
    end
  end
  
  def solve_with(solution = Hash.new)
    if exercise_type and @solver = exercise_type.implementor_instance
      solver.fill(self.context)
      solver.solve(solution)
    end
  end
end
