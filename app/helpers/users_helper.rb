module UsersHelper
  
  def show_badges(badges)
    content_tag :ul, class: 'badges' do
      badges.map do |badge|
        course = badge.course
        
        title = "#{badge.name} del curso #{course.name}"
        
        badge_course = link_to course.name, course, class: 'badge-course', target: '_blank'
        badge_name = link_to badge.name, course_badge_url(course, badge), class: 'badge-name', target: '_blank'
        
        text = badge_course + badge_name
        
        content_tag :li, title: title, class: 'badge' do
          img = image_tag(badge.image.url(:thumb)) + content_tag(:div, text)
          link_to img, course_badge_url(course, badge)
        end
      end.join('').html_safe
    end
  end
  
end