module ExerciseTypes
  class Alternatives < SuperType
    
    def requirements
      %w{answer alternatives}
    end
    
    def solve(solution)
      student_answer = solution[:answer]
      case student_answer
        when String
          student_answer == @data[:answer]
        when Fixnum
          @data[:alternatives][student_answer] == @data[:answer]
        end
    end
  end
end