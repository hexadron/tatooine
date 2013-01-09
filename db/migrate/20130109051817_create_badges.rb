class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.references :course
      t.boolean :active
      t.string :name

      t.timestamps
    end
    add_attachment :badges, :image
    add_index :badges, :course_id
  end
end
