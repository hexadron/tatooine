class Section < ActiveRecord::Base
  belongs_to :course_session
  has_many :exercises
  attr_accessible :content, :title
end