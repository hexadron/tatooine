class RemoveEvaluationIdFromExercises < ActiveRecord::Migration
  def up
    remove_column :exercises, :evaluation_id
  end

  def down
    add_column :exercises, :evaluation_id, :integer
  end
end
