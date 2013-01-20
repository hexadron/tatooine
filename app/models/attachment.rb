class Attachment < ActiveRecord::Base
  belongs_to :section
  
  has_attached_file :file, whiny: false
  
  validates :file, presence: true, on: :update
  
  attr_accessible :file, :displayable

  before_save :set_displayable
  
  def set_displayable
    @displayable ||= false
    true
  end

end
