class DropDistinctions < ActiveRecord::Migration
  def change
    drop_table :distinctions
  end
end
