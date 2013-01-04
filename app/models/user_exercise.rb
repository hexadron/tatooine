class UserExercise < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :user
  attr_accessible :result
end
