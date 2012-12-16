class ChangeFeedbackTextToText < ActiveRecord::Migration
  def up
    change_column :feedbacks, :text, :text
  end

  def down
    change_column :feedbacks, :text, :string
  end
end
