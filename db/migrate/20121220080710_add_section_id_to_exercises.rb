class AddSectionIdToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :section_id, :integer
    add_index :exercises, :section_id
  end
end
