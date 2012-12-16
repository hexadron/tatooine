class Feedback < ActiveRecord::Base
  attr_accessible :text

  belongs_to :course
  belongs_to :user
  
  validates :text, presence: true

end