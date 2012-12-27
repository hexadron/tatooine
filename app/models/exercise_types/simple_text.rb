# encoding: utf-8

module ExerciseTypes
  class SimpleText < SuperType
    
    def requirements
      %w{answer}
    end
    
    def solve(solution)
      @data[:answer] == solution[:answer]
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