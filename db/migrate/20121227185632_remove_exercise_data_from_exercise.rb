class RemoveExerciseDataFromExercise < ActiveRecord::Migration
  def up
    remove_column :exercises, :exercise_data
  end

  def down
    add_column :exercises, :exercise_data, :text
  end
end
