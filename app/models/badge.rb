class Badge < ActiveRecord::Base
  belongs_to :course
  attr_accessible :active, :name, :event, :image, :course_id
  
  has_attached_file :image
  
  after_initialize :set_active_to_false

  validates :name, presence: true
  validates :event, presence: true
  
  def confer(user)
    possible_ubs = UserBadge.where(user_id: user.id, badge_id: self.id)
    ub = if possible_ubs.empty?
      nub = UserBadge.new
      nub.user_id = user.id
      nub.badge_id = self.id
      nub
    else
      possible_ubs.first
    end
    
    ub.awarded = true
    ub.save
  end
  
  def set_active_to_false
    self.active ||= false
    true
  end
  
  def self.for(course, event, hash)
    complete_event = "#{event}#{hash_to_colon_pairs(hash)}"
    
    if course.present?
      query = { course_id: course.id, event: complete_event, active: true }
    else
      query = { event: complete_event, active: true }
    end
    
    if badge = Badge.where(query).first
      badge
    else
      Badge.new
    end
  end
  
  def self.hash_to_colon_pairs(hash)
    hash.inject("") do |colon_pairs, (k, v)|
      colon_pairs + "::#{k.to_s}:#{v.to_s}"
    end
  end
end
