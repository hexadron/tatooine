class UserSection < ActiveRecord::Base
  include BadgeTrigger
  
  belongs_to :section
  belongs_to :user
  attr_accessible :progress
  
  def check_for_badges
    check_object = {}
    
    check_object[:result] = false
    
    if section.present? and user.present?
      total = section.exercises.count
      if progress == total and total > 0
        check_object = trigger_for_badge(
          event: 'sections::complete',
          user: user,
          additional: {
            section_id: section.id
          }
        )
      end
    end
    
    check_object
  end
end
