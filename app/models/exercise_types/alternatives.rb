module ExerciseTypes
  class Alternatives < SuperType
    
    def requirements
      %w{answer alternatives}
    end
    
    def solve(solution)
      student_answer = solution[:answer]
      case student_answer
        when String # Match string content
          student_answer == @data[:answer]
        when Fixnum # Match index position
          @data[:alternatives][student_answer] == @data[:answer]
        end
    end
  end
end