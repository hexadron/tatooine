class Course < ActiveRecord::Base
  attr_accessible :available_at, :can_be_published, :difficulty, :name
end
