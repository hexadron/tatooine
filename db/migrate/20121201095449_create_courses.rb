class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :difficulty
      t.string :name
      t.date :available_at
      t.boolean :can_be_published

      t.timestamps
    end
  end
end
