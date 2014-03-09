class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.decimal :entry_fee
      t.references :user, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
