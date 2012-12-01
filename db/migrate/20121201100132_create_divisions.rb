class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.integer :level
      t.references :course

      t.timestamps
    end
    add_index :divisions, :course_id
  end
end
