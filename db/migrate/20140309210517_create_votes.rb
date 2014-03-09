class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :entry, index: true
      t.references :user, index: true
      t.integer :event_id

      t.timestamps
    end
  end
end
