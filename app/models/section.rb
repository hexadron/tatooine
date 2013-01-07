# encoding: utf-8

class Section < ActiveRecord::Base
  belongs_to :course_session
  has_many :exercises
  has_many :user_sections
  attr_accessible :content, :title
  
  validates_presence_of :title, :message => "no puede estar en blanco"
  
  def progress_for(user)
    total = exercises.count
    sect_data = user.section_data_for(self)
    progress = sect_data.progress
    
    percent = safe_percent(progress, total).round
    
    { total: total, done: progress, percent: percent }
  end
  
  private
  
  def safe_percent(fraction, total)
    if total == 0
      100
    else
      (fraction / total) * 100
    end
  end
  
end