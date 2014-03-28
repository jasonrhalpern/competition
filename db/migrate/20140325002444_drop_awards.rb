class DropAwards < ActiveRecord::Migration
  def change
    drop_table :awards
  end
end
