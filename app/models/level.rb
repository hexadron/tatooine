# encoding: utf-8

class Level < ActiveRecord::Base
  attr_accessible :name, :position
  
  belongs_to :course
  
  class << self
    def basic
      Level.where(name: "básico").first
    end
  end
end
