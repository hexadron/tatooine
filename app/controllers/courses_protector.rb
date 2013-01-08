module CoursesProtector
  
  def protect_courses
    # El método load_course debe ser definido por la clase que incluya al protector
    load_course if @course.nil?
    if @course.creator != current_user
      redirect_to '/404.html'
    end
  end
  
end