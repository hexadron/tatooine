class AddKindToExerciseTypes < ActiveRecord::Migration
  def change
    add_column :exercise_types, :kind, :string
  end
end
