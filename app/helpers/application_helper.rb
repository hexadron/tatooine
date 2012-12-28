module ApplicationHelper
  def link_to_javascript(content, attrs = {})
    link_to(content, "javascript:void(0);", attrs)
  end
  
  def are_you_enrolled?(course)
    current_user.courses.include?(course)
  end
  
  def format_errors(model)
    errors = model.errors.full_messages
    errors.map do |error|
      "<li><p>#{error}</p></li>"
    end.join.html_safe
  end
end
