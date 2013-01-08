class AddAnswerToUserExercises < ActiveRecord::Migration
  def change
    add_column :user_exercises, :answer, :text
  end
end
