module ExerciseTypes
  class SimpleText < SuperType
    
    def requirements
      %w{answer}
    end
    
    def solve(solution)
      @data[:answer] == solution[:answer]
    end
  end
end