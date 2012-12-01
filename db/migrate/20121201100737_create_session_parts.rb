class CreateSessionParts < ActiveRecord::Migration
  def change
    create_table :session_parts do |t|
      t.string :title
      t.text :content
      t.references :course_session

      t.timestamps
    end
    add_index :session_parts, :course_session_id
  end
end
