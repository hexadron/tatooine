class AddDisplayableToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :displayable, :boolean
  end
end
