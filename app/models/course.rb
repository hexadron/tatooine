class Course < ActiveRecord::Base
  attr_accessible :available_at, :can_be_published, :description, :name, :level_id
  
  validates :name, presence: true
  validates :description, presence: true
  
  belongs_to :level
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  
  has_many :enrollments
  has_many :students, through: :enrollments, source: :user
  
  def load_defaults!
    self.available_at ||= Date.today
    self.can_be_published ||= true
    self.level = Level.basic
  end
  
  def add_student(user)
    enrollment = Enrollment.new
    enrollment.user = user
    enrollment.course = self
    enrollment.save
  end
  
  class << self
    def with_level(level)
      self.joins(:level).where("levels.name = ?", level)
    end
  end
end
