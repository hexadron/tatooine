# encoding: utf-8

class Level < ActiveRecord::Base
  attr_accessible :name, :position

  has_many :courses
  
  class << self
    def basic
      Level.where(name: "Básico").first
    end
  end
end
