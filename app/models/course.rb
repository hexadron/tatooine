class Course < ActiveRecord::Base
  attr_accessible :available_at, :can_be_published, :description, :name, :level_id, :faq, :creator_id, :background_image
  
  validates :name, presence: true
  validates :description, presence: true
  
  belongs_to :level
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  
  has_attached_file :background_image,
    :styles => { :medium => "300x300>", :thumb => "100x100>", :tile => '225>x127>' },
    :storage => :Dropboxstorage,
    :default_url => "/images/:style/missing.png",
    :path => "/tatooine/:attachment/:id/:style/:filename"
  
  has_many :enrollments
  has_many :feedbacks
  has_many :students, through: :enrollments, source: :user
  has_many :course_sessions
  
  after_initialize :load_defaults!
  
  def load_defaults!
    self.available_at ||= Date.today
    self.can_be_published = true if self.can_be_published.nil?
    self.level ||= Level.basic
  end
  
  def add_student(user)
    enrollment = Enrollment.new
    enrollment.user = user
    enrollment.course = self
    enrollment.save
  end
  
  def available?
    available_at <= Date.today
  end
  
  def ranking
    enrollments.order('score desc').each_with_index.map do |enrollment, idx|
      { user: enrollment.user, score: enrollment.score, position: idx + 1 }
    end
  end
  
  def ranking_for(user)
    position = enrollments.order('score desc').each_with_index.select do |e, i|
      e.user_id == user.id
    end.flatten[1]
    
    if position.present?
      position + 1
    else
      nil
    end
  end
  
  class << self
    def availables
      self.where("available_at <= ?", Date.today).where(can_be_published: true)
    end
    
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
        xs.select { |row|
          row.enrollment_user_id == user.id
        }.uniq
      else
        self.joins(:enrollments).select("courses.*, enrollments.user_id").where("enrollments.user_id = ?", user.id)
      end
    end
  end
end
