class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :title
      t.string :text

      t.timestamps
    end
  end
end
