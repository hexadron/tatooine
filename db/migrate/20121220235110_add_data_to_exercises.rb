class AddDataToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :data, :text
  end
end
