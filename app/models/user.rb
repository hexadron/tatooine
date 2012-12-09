# encoding: utf-8

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password,
                  :password_confirmation, :remember_me, :provider, :uid

  has_many :creations, :class_name => "Course", :foreign_key => "creator_id"
  
  has_many :enrollments
  has_many :courses, :through => :enrollments

  def name
    self.first_name || self.email
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
    return _teachers
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
  end

  def self.teachers
    self.all.select { |teacher| teacher.courses.count > 0 }
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
