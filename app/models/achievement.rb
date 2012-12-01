class Achievement < ActiveRecord::Base
  belongs_to :course
  belongs_to :evaluation
  attr_accessible :description, :name
end
