class Exercise < ActiveRecord::Base
  belongs_to :exercise_type
  belongs_to :evaluation
  attr_accessible :question, :result
end
