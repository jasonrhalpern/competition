class AddVotesCountToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :votes_count, :integer, default: 0
  end
end
