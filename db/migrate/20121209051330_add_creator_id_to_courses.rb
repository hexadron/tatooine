class AddCreatorIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :creator_id, :integer
    
    add_index :courses, :creator_id
  end
end
