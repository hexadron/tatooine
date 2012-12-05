module ExerciseTypes
  class SuperType
    attr_accessor :data, :errors
    
    def fill(data)
      @data = data
    end
  end
end