class CourseSession < ActiveRecord::Base
  belongs_to :division
  belongs_to :course
  attr_accessible :content, :title
end
