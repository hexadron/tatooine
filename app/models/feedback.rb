class Feedback < ActiveRecord::Base
  attr_accessible :text, :title

  belongs_to :course
  belongs_to :user

end