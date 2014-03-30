class RemoveEventRefFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :event_id
  end
end
