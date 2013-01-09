class AddEventToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :event, :string
  end
end
