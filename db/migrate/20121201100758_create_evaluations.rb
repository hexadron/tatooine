class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :session_part
      t.references :course_session

      t.timestamps
    end
    add_index :evaluations, :session_part_id
    add_index :evaluations, :course_session_id
  end
end
