module ExerciseTypes
  class MultipleTrueOrFalse < SuperType
    
    def requirements
      %w{questions answers}
    end
    
    def solve(solution)
      user_answers = solution[:answers]
      @errors = []
      
      data[:questions].each_with_index do |(question, answer), i|
        user_answer = !!user_answers[i]
        
        unless !!answer == user_answer
          @errors << { question: question, good_answer: answer, bad_answer: user_answer }
        end
      end
      
      @errors.empty?
    end
  end
end