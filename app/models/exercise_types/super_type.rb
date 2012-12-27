module ExerciseTypes
  # Alias MaximumSolver :P
  class SuperType
    attr_accessor :data, :errors, :invalidations
    
    # Sólo mezcla el hash interno de data con el
    # hash de parámetro
    def fill(data)
      @data ||= {}
      @data = @data.merge(data)
    end
    
    def validate(solution)
      @invalidations = []
      @invalidations.count == 0
    end
    
    def solve_exercise(solution)
      unless validate(solution)
        return false
      end
      return self.solve(solution)
    end
  end
end