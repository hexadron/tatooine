class RemoveDifficultyFromCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :difficulty
  end

  def down
    add_column :courses, :difficulty, :string
  end
end
