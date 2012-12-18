class Section < ActiveRecord::Base
  belongs_to :course_session
  attr_accessible :content, :title
end