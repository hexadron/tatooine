class Exercise < ActiveRecord::Base
  belongs_to :exercise_type
  belongs_to :section
  attr_accessible :question, :result, :exercise_type_id
  
  attr_accessor :context, :solver
  
  after_initialize :create_context
  
  
  before_save :sync_definitions
  
  def formatted_question(type="html")
    if type.to_s == "html"
      exercise_type.formatted_question
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
    exercise_type.update_implementor! if exercise_type
    if exercise_type and @solver = exercise_type.implementor_instance
      load_context
      
      solver.fill(self.context)
      solver.solve(solution)
    end
  end
  
  def load_context
    if self.data and self.context.empty?
      decoded = ActiveSupport::JSON.decode self.data
      
      # Transformamos los hashes de "string" => OTHER to
      # :string => OTHER.
      self.context = decoded.inject({}) do |h, (k, v)|
        h[k.to_sym] = v
        h
      end
    end
  end
  
  def sync_definitions
    if self.context
      serialized_context = ActiveSupport::JSON.encode self.context
      self.data = serialized_context
      self
    end
  end
end
