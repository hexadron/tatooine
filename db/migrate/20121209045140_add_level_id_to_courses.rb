class AddLevelIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :level_id, :integer
    add_index :courses, :level_id
  end
end
