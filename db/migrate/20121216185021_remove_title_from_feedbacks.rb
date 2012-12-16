class RemoveTitleFromFeedbacks < ActiveRecord::Migration
  def up
    remove_column :feedbacks, :title
  end

  def down
    add_column :feedbacks, :title, :string
  end
end
