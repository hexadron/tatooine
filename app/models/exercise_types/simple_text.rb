# encoding: utf-8

module ExerciseTypes
  class SimpleText < SuperType
    
    def requirements
      %w{answer}
    end
    
    def solve(solution)
      correct = @data[:answer]
      candidate = solution[:answer]
      if correct and candidate
        @data[:answer].downcase == solution[:answer].downcase
      else
        false
      end
    end
    
    def validate(solution)
      @invalidations = []
      if solution[:answer].empty?
        @invalidations << "Respuesta vacía"
      end
      @invalidations.count == 0
    end
    
  end
end