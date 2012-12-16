module ApplicationHelper
  def link_to_javascript(content, attrs = {})
    link_to(content, "javascript:void(0);", attrs)
  end
end
