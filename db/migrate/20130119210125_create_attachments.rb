class CreateAttachments < ActiveRecord::Migration
  def change
    
    create_table :attachments do |t|

      t.references :section

      t.timestamps
    end

    add_attachment :attachments, :file

  end
end
