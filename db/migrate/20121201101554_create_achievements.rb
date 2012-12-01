class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.references :course
      t.references :evaluation
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :achievements, :course_id
    add_index :achievements, :evaluation_id
  end
end
