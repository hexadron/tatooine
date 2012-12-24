module ExerciseTypes
  # Alias MaximumSolver :P
  class SuperType
    attr_accessor :data, :errors
    
    # Sólo mezcla el hash interno de data con el
    # hash de parámetro
    def fill(data)
      @data ||= {}
      @data = @data.merge(data)
    end
  end
end