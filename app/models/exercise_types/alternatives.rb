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
    
    def validate(solution)
      @invalidations = []
      if solution.nil?
        @invalidations << "No hay ninguna alternativa seleccionada."
      end
      @invalidations.count == 0
    end
  end
end