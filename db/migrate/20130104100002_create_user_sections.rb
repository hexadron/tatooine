class CreateUserSections < ActiveRecord::Migration
  def change
    create_table :user_sections do |t|
      t.references :section
      t.references :user
      t.integer :progress

      t.timestamps
    end
    add_index :user_sections, :section_id
    add_index :user_sections, :user_id
  end
end
