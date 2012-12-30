class AddBackgroundImageToCourses < ActiveRecord::Migration
  def change
    add_attachment :courses, :background_image
  end
end
