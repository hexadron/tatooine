# encoding: utf-8

class Section < ActiveRecord::Base
  belongs_to :course_session
  has_many :exercises
  attr_accessible :content, :title
  
  validates_presence_of :title, :message => "no puede estar en blanco"
end