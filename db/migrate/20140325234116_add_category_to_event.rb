class AddCategoryToEvent < ActiveRecord::Migration
  def change
    add_column :events, :category, :integer
  end
end
