class RemoveResultFromExercise < ActiveRecord::Migration
  def up
    remove_column :exercises, :result
  end

  def down
    add_column :exercises, :result, :text
  end
end
