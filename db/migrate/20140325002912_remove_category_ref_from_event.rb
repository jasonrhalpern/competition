class RemoveCategoryRefFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :category_id
  end
end
