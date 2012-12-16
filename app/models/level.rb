# encoding: utf-8

class Level < ActiveRecord::Base
  attr_accessible :name, :position, :course_id

  attr_accessor :course_id
  
  class << self
    def basic
      Level.where(name: "básico").first
    end
  end
end
