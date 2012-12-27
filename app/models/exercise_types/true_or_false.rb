module ExerciseTypes
  class TrueOrFalse < SuperType
    
    def requirements
      %w{answer}
    end
    
    def solve(solution)
      answer = solution[:answer]
      answer = true if ["1", 1].include?(answer)
      answer = false if ["0", 0].include?(answer)
      
      !!@data[:answer] == !!answer
    end
  end
end