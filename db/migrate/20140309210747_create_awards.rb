class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.references :distinction, index: true
      t.references :entry, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
