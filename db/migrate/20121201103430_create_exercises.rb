class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.text :question
      t.text :result
      t.references :exercise_type
      t.references :evaluation

      t.timestamps
    end
    add_index :exercises, :exercise_type_id
    add_index :exercises, :evaluation_id
  end
end
