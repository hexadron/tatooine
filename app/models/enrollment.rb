class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  before_save :set_score_to_zero
  
  def set_score_to_zero
    self.score = 0 if self.score.nil?
    true
  end
end