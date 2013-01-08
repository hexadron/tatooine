class UserSection < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  attr_accessible :progress
end
