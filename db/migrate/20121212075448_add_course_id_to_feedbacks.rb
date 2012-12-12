class AddCourseIdToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :course_id, :integer
  end
end
