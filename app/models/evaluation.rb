class Evaluation < ActiveRecord::Base
  belongs_to :session_part
  belongs_to :course_session
  # attr_accessible :title, :body
end
