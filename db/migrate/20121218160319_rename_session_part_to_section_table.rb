class RenameSessionPartToSectionTable < ActiveRecord::Migration
  def change
    rename_table :session_parts, :sections
  end
end
