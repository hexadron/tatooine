module BadgeTrigger
  
  def trigger_for_badge(options)
    result = false
    
    badge = Badge.for(options[:course], options[:event], options[:additional])
    if badge.present? and !badge.new_record?
      result = badge.confer(options[:user])
    end
    
    { result: result, badge: badge }
  end
end