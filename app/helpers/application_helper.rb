module ApplicationHelper
  def link_to_javascript(content, attrs = {})
    link_to(content, "javascript:void(0);", attrs)
  end
  
  def are_you_enrolled?(course)
    current_user.courses.include?(course)
  end
end
