class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :description
      t.references :evaluation
      t.references :course

      t.timestamps
    end
    add_index :badges, :evaluation_id
    add_index :badges, :course_id
  end
end
