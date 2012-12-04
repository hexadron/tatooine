class Evaluation < ActiveRecord::Base
  belongs_to :session_part
  belongs_to :course_session
  
  has_many :exercises
end
