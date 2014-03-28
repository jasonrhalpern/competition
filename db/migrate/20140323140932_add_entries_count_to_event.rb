class AddEntriesCountToEvent < ActiveRecord::Migration
  def change
    add_column :events, :entries_count, :integer, default: 0
  end
end
