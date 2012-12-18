class CourseSession < ActiveRecord::Base
  belongs_to :division
  belongs_to :course
  
  has_many :sections
  
  attr_accessible :content, :title
  
  validates :title, presence: true
  validates :content, presence: true
end
