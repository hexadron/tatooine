class Evaluation < ActiveRecord::Base
  belongs_to :section
  belongs_to :course_session
  
  has_many :exercises
end