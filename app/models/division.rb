class Division < ActiveRecord::Base
  belongs_to :course
  attr_accessible :level
end
