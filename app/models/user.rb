# encoding: utf-8

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :complete_name, :email, :password,
                  :password_confirmation, :remember_me, :provider, :uid, :old_password, :edit_password, :avatar
  
  has_attached_file :avatar

  attr_accessor :old_password, :edit_password

  has_many :creations, :class_name => "Course", :foreign_key => "creator_id"
  
  has_many :enrollments
  has_many :courses, :through => :enrollments
  has_many :user_exercises
  has_many :user_sections

  def name
    strip_email(self.first_name || self.email)
  end

  def complete_name
    if self.first_name && self.last_name
      "#{self.first_name} #{self.last_name}"
    else
      strip_email self.name
    end
  end

  def strip_email(email)
    index = email.index '@'
    index ? email[0..(index - 1)] : email
  end
  
  def average_level
    "Básico"
  end

  def teachers
    _teachers = []
    self.courses.each do |course|
      teacher = course.creator
      unless _teachers.index teacher
        _teachers.push teacher
      end
    end
    _teachers
  end

  def students
    # TODO: esto se puede optimizar
    _students = []
    self.creations.each do |course|
      course.students.each do |student|
        unless _students.index student
          _students.push student
        end
      end
    end
    _students
  end
  
  def exercise_data_for(exercise)
    maybe_usxs = UserExercise.where(exercise_id: exercise.id, user_id: self.id)
    if maybe_usxs.empty?
      ue = UserExercise.new
      ue.exercise = exercise
      ue.user = self
      ue.result = false
      ue.save
      ue
    else
      maybe_usxs.first
    end
  end
  
  def section_data_for(section)
    maybe_uses = UserSection.where(section_id: section.id, user_id: self.id)
    if maybe_uses.empty?
      us = UserSection.new
      us.section = section
      us.user = self
      us.progress = 0
      us.save
      us
    else
      maybe_uses.first
    end
  end
  
  def make_exercise_data_with(exercise, answer)
    ex = exercise_data_for(exercise)
    ex.answer = answer
    ex.result = exercise.solve_with(answer)
    ex.save
    ex
  end
  
  def update_section_progress(section, result)
    sect = section_data_for(section)
    
    if result
      sect.progress += 1
    else
      sect.progress -= 1 unless sect.progress.zero?
    end
    sect.save
    sect.progress
  end
  
  def update_ranking(course, progress)
    if progress != 0
      enrollment = Enrollment.where(course_id: course.id, user_id: self.id).first
      enrollment.score = 0 if enrollment.score.nil?
      enrollment.score += progress
      enrollment.save
    end
  end
  
  def solve(exercise, answer)
    ue = make_exercise_data_with(exercise, answer)
    section = exercise.section
    
    progress = update_section_progress(section, ue.result)
    
    if ue.result
      update_ranking(section.course_session.course, progress)
    end
    
    { result: ue.result, mistakes: exercise.mistakes, invalidations: exercise.invalidations, ue: ue }
  end

  def self.teachers
    self.all.select { |teacher| teacher.creations.count > 0 }
  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create first_name: auth.extra.raw_info.first_name,
        last_name: auth.extra.raw_info.last_name,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create first_name: auth.extra.raw_info.screen_name,
        provider: auth.provider,
        uid: auth.uid,
        email: "#{auth.extra.raw_info.screen_name}#{rand(100000)}@twitter.com",
        password: Devise.friendly_token[0, 20]
    end
    user
  end

end
