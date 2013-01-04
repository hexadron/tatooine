class CreateUserExercises < ActiveRecord::Migration
  def change
    create_table :user_exercises do |t|
      t.references :exercise
      t.references :user
      t.boolean :result

      t.timestamps
    end
    add_index :user_exercises, :exercise_id
    add_index :user_exercises, :user_id
  end
end
