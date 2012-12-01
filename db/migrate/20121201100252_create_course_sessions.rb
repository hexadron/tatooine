class CreateCourseSessions < ActiveRecord::Migration
  def change
    create_table :course_sessions do |t|
      t.string :title
      t.text :content
      t.references :division
      t.references :course

      t.timestamps
    end
    add_index :course_sessions, :division_id
    add_index :course_sessions, :course_id
  end
end
