class AddFaqToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :faq, :string
  end
end
