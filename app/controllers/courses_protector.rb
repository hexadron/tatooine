module CoursesProtector
  
  module InstanceMethods
    def protect_courses
      # El método load_course debe ser definido por la clase que incluya al protector
      load_course
      if @course.creator != current_user
        redirect_to '/404.html'
      end
    end
  end
  
  def self.included(receiver)
    receiver.before_filter :protect_courses, only: [:index, :edit, :update, :destroy, :new, :create, :customize]
    receiver.send :include, InstanceMethods
  end
  
end