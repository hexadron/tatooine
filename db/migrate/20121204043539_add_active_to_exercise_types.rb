class AddActiveToExerciseTypes < ActiveRecord::Migration
  def change
    add_column :exercise_types, :active, :boolean
  end
end
