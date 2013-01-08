# encoding: utf-8

class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  before_save :set_score_to_zero
  
  validate :user_should_not_be_the_course_creator
  
  def set_score_to_zero
    self.score = 0 if self.score.nil?
    true
  end
  
  def user_should_not_be_the_course_creator
    if course and user
      if course.creator_id == user.id
        errors[:base] << "El creador de un curso no puede registrarse en éste."
      end
    end
  end
end