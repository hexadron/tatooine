class AddExerciseDataToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :exercise_data, :text
  end
end
