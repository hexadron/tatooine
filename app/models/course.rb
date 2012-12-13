class Course < ActiveRecord::Base
  attr_accessible :available_at, :can_be_published, :description, :name, :level_id, :faq
  
  validates :name, presence: true
  validates :description, presence: true
  
  belongs_to :level
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  
  has_many :enrollments
  has_many :feedbacks
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
    def with_level(level, options = { array: false })
      if xs = options[:array]
        xs.select { |row|
          row.level_name == level
        }.uniq
      else
        self.joins(:level).where("levels.name = ?", level)
      end
    end
    
    def created_by(user, options = { array: false })
      if xs = options[:array]
        xs.select { |row|
          row.creator_id == user.id
        }.uniq
      else
        self.where(creator_id: user.id)
      end
    end
    
    def taken_by(user, options = { array: false })
      if xs = options[:array]
        puts xs
        xs.select { |row|
          row.enrollment_user_id == user.id
        }.uniq
      else
        self.joins(:enrollments).select("courses.*, enrollments.*").where("enrollments.user_id = ?", user.id)
      end
    end
  end
end
