class AddAwardToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :award, :integer, default: 0
  end
end
