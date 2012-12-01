class Badge < ActiveRecord::Base
  belongs_to :evaluation
  belongs_to :course
  attr_accessible :description, :name
end
